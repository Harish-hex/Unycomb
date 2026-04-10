import 'dart:async';

import 'package:nexus/shared/mock/mock_data.dart';
import 'package:nexus/shared/models/conversation_model.dart';
import 'package:nexus/shared/models/match_model.dart';
import 'package:nexus/shared/models/mentor_model.dart';
import 'package:nexus/shared/models/message_model.dart';
import 'package:nexus/shared/models/opportunity_model.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/review_model.dart';
import 'package:nexus/shared/models/task_model.dart';
import 'package:nexus/shared/models/user_model.dart';

class MockAppStore {
  MockAppStore()
      : _projects = mockProjects(),
        _matches = List<MatchModel>.from(mockMatches),
        _opportunities = List<OpportunityModel>.from(mockOpportunities),
        _reviews = List<ReviewModel>.from(mockReviews),
        _conversations = List<ConversationModel>.from(mockConversations),
        _messages = List<MessageModel>.from(mockMessages),
        _mentors = List<MentorModel>.from(mockMentors);

  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  bool _isAuthenticated = false;
  String? _pendingEmail;
  UserModel _currentUser = mockCurrentUser;
  final List<ProjectModel> _projects;
  final List<MatchModel> _matches;
  final List<OpportunityModel> _opportunities;
  final List<ReviewModel> _reviews;
  final List<ConversationModel> _conversations;
  final List<MessageModel> _messages;
  final List<MentorModel> _mentors;

  Stream<bool> get authStateChanges => _authStateController.stream;
  bool get isAuthenticated => _isAuthenticated;
  String? get pendingEmail => _pendingEmail;
  UserModel get currentUser => _currentUser;
  List<ProjectModel> get projects => List<ProjectModel>.from(_projects);
  List<MatchModel> get matches => List<MatchModel>.from(_matches);
  List<OpportunityModel> get opportunities =>
      List<OpportunityModel>.from(_opportunities);
  List<ReviewModel> get reviews => List<ReviewModel>.from(_reviews);
  List<ConversationModel> get conversations =>
      List<ConversationModel>.from(_conversations);
  List<MessageModel> messagesFor(String conversationId) {
    return _messages
        .where(
          (MessageModel message) => message.conversationId == conversationId,
        )
        .toList();
  }

  List<MentorModel> get mentors => List<MentorModel>.from(_mentors);

  Future<void> sendOtp(String email) async {
    _pendingEmail = email;
  }

  Future<void> verifyOtp(String code) async {
    if (code.length != 6) {
      throw Exception('OTP must be 6 digits.');
    }
    _isAuthenticated = true;
    _authStateController.add(true);
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _authStateController.add(false);
  }

  Future<void> saveProfile({
    required String name,
    required String year,
    required List<String> skills,
    String? avatarUrl,
  }) async {
    _currentUser = _currentUser.copyWith(
      name: name,
      year: year,
      skills: skills,
      avatarUrl: avatarUrl ?? _currentUser.avatarUrl,
      profileCompletionPercent: 100,
      email: _pendingEmail ?? _currentUser.email,
    );
  }

  Future<void> requestCollab(String userId) async {
    final int index = _matches.indexWhere(
      (MatchModel item) => item.user.id == userId,
    );
    if (index == -1) {
      return;
    }
    _matches[index] = _matches[index].copyWith(
      matchStatus: MatchStatus.requested,
    );
  }

  Future<void> updateTaskStatus({
    required String projectId,
    required String taskId,
    required TaskStatus newStatus,
  }) async {
    final int projectIndex = _projects.indexWhere(
      (ProjectModel item) => item.id == projectId,
    );
    if (projectIndex == -1) {
      return;
    }
    final ProjectModel project = _projects[projectIndex];
    final List<TaskModel> tasks = project.tasks.map((TaskModel task) {
      if (task.id != taskId) {
        return task;
      }
      return task.copyWith(status: newStatus);
    }).toList();
    _projects[projectIndex] = project.copyWith(
      tasks: tasks,
      openTaskCount: tasks
          .where((TaskModel task) => task.status != TaskStatus.done)
          .length,
      progress: tasks.isEmpty
          ? 0
          : tasks
                  .where((TaskModel task) => task.status == TaskStatus.done)
                  .length /
              tasks.length,
    );
  }

  Future<void> sendMessage({
    required String conversationId,
    required String text,
  }) async {
    _messages.add(
      MessageModel(
        id: 'msg_${_messages.length + 1}',
        conversationId: conversationId,
        body: text,
        isMine: true,
        sentAt: DateTime.now(),
      ),
    );
  }
}
