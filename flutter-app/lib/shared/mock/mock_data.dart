import 'package:nexus/shared/models/conversation_model.dart';
import 'package:nexus/shared/models/match_model.dart';
import 'package:nexus/shared/models/mentor_model.dart';
import 'package:nexus/shared/models/message_model.dart';
import 'package:nexus/shared/models/opportunity_model.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/review_model.dart';
import 'package:nexus/shared/models/task_model.dart';
import 'package:nexus/shared/models/user_model.dart';

final UserModel mockCurrentUser = UserModel(
  id: 'u_1',
  name: 'Aarav Raman',
  email: 'aarav@uni.edu',
  university: 'National Tech University',
  year: '3rd Year',
  avatarUrl: '',
  skills: const <String>['Flutter', 'Product', 'ML'],
  reputationScore: 4.8,
  reviewCount: 27,
  profileCompletionPercent: 88,
);

final List<UserModel> mockUsers = <UserModel>[
  mockCurrentUser,
  const UserModel(
    id: 'u_2',
    name: 'Nia Thomas',
    email: 'nia@uni.edu',
    university: 'National Tech University',
    year: '2nd Year',
    avatarUrl: '',
    skills: <String>['Backend', 'Django', 'Cloud'],
    reputationScore: 4.9,
    reviewCount: 18,
    profileCompletionPercent: 92,
  ),
  const UserModel(
    id: 'u_3',
    name: 'Rohan Shah',
    email: 'rohan@uni.edu',
    university: 'City Engineering College',
    year: '4th Year',
    avatarUrl: '',
    skills: <String>['Design', 'Brand', 'UI'],
    reputationScore: 4.7,
    reviewCount: 14,
    profileCompletionPercent: 80,
  ),
  const UserModel(
    id: 'u_4',
    name: 'Mira Patel',
    email: 'mira@uni.edu',
    university: 'National Tech University',
    year: '1st Year',
    avatarUrl: '',
    skills: <String>['Mobile', 'Firebase', 'UX'],
    reputationScore: 4.6,
    reviewCount: 11,
    profileCompletionPercent: 75,
  ),
];

List<TaskModel> mockTasks() {
  return <TaskModel>[
    TaskModel(
      id: 't_1',
      title: 'Design onboarding visuals',
      assignee: mockUsers[2],
      dueDate: DateTime.now().add(const Duration(days: 2)),
      status: TaskStatus.todo,
    ),
    TaskModel(
      id: 't_2',
      title: 'Ship auth API contract',
      assignee: mockUsers[1],
      dueDate: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.inProgress,
    ),
    TaskModel(
      id: 't_3',
      title: 'Polish feed microcopy',
      assignee: mockCurrentUser,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      status: TaskStatus.done,
    ),
  ];
}

List<ProjectModel> mockProjects() {
  final List<TaskModel> tasks = mockTasks();
  return <ProjectModel>[
    ProjectModel(
      id: 'p_1',
      name: 'HackSprint HQ',
      members: <UserModel>[mockCurrentUser, mockUsers[1], mockUsers[2]],
      progress: 0.68,
      openTaskCount: 4,
      status: ProjectStatus.active,
      tasks: tasks,
      role: 'Product Lead',
      techStack: const <String>['Flutter', 'FastAPI', 'Postgres'],
    ),
    ProjectModel(
      id: 'p_2',
      name: 'LabLink',
      members: <UserModel>[mockCurrentUser, mockUsers[3]],
      progress: 0.42,
      openTaskCount: 7,
      status: ProjectStatus.paused,
      tasks: tasks.reversed.toList(),
      role: 'Mobile Engineer',
      techStack: const <String>['Dart', 'Firebase', 'Figma'],
    ),
  ];
}

final List<MatchModel> mockMatches = <MatchModel>[
  MatchModel(
    id: 'm_1',
    user: mockUsers[1],
    bio: 'Backend builder who likes hackathons with real users, not toy demos.',
    matchStatus: MatchStatus.suggested,
  ),
  MatchModel(
    id: 'm_2',
    user: mockUsers[2],
    bio:
        'Brand-first designer looking for ambitious teams shipping this month.',
    matchStatus: MatchStatus.suggested,
  ),
  MatchModel(
    id: 'm_3',
    user: mockUsers[3],
    bio: 'Mobile generalist into Firebase, motion, and fast iteration loops.',
    matchStatus: MatchStatus.requested,
  ),
];

final List<OpportunityModel> mockOpportunities = <OpportunityModel>[
  OpportunityModel(
    id: 'o_1',
    title: 'MLH Build Sprint 2026',
    source: 'MLH',
    sourceLogoUrl: '',
    deadline: DateTime.now().add(const Duration(days: 4)),
    tags: const <String>['48hr', 'Remote', 'Prize'],
    description:
        'Fast-moving hackathon for student builders shipping polished MVPs.',
    type: OpportunityType.hackathon,
  ),
  OpportunityModel(
    id: 'o_2',
    title: 'Open Source Design Collab',
    source: 'Campus Guild',
    sourceLogoUrl: '',
    deadline: DateTime.now().add(const Duration(days: 10)),
    tags: const <String>['Design', 'Portfolio', 'Remote'],
    description:
        'Join a student design pod helping maintainers refresh onboarding UX.',
    type: OpportunityType.collab,
  ),
  OpportunityModel(
    id: 'o_3',
    title: 'National Product Case Cup',
    source: 'ProdSoc',
    sourceLogoUrl: '',
    deadline: DateTime.now().add(const Duration(days: 6)),
    tags: const <String>['Pitch', 'Teams', 'Campus'],
    description:
        'Cross-campus competition for founders and operators with strong storytelling.',
    type: OpportunityType.competition,
  ),
];

final List<ReviewModel> mockReviews = <ReviewModel>[
  ReviewModel(
    id: 'r_1',
    fromUser: mockUsers[1],
    rating: 5,
    text:
        'Keeps the team calm under pressure and turns ambiguity into a real roadmap.',
    createdAt: DateTime.now().subtract(const Duration(days: 12)),
  ),
  ReviewModel(
    id: 'r_2',
    fromUser: mockUsers[2],
    rating: 4.5,
    text:
        'Strong product instincts and unusually thoughtful with feedback loops.',
    createdAt: DateTime.now().subtract(const Duration(days: 28)),
  ),
];

final List<ConversationModel> mockConversations = <ConversationModel>[
  ConversationModel(
    id: 'c_1',
    participant: mockUsers[1],
    lastMessage: 'I can take the API auth flow tonight.',
    updatedAt: DateTime.now().subtract(const Duration(minutes: 16)),
    unreadCount: 2,
  ),
  ConversationModel(
    id: 'c_2',
    participant: mockUsers[2],
    lastMessage: 'Uploaded the revised hero concepts.',
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    unreadCount: 0,
  ),
];

final List<MessageModel> mockMessages = <MessageModel>[
  MessageModel(
    id: 'msg_1',
    conversationId: 'c_1',
    body: 'Can you push the latest API docs?',
    isMine: true,
    sentAt: DateTime.now().subtract(const Duration(minutes: 18)),
  ),
  MessageModel(
    id: 'msg_2',
    conversationId: 'c_1',
    body: 'I can take the API auth flow tonight.',
    isMine: false,
    sentAt: DateTime.now().subtract(const Duration(minutes: 16)),
  ),
];

final List<MentorModel> mockMentors = <MentorModel>[
  MentorModel(
    user: mockUsers[1],
    expertise: const <String>['Backend', 'Scaling', 'Cloud'],
    isAvailable: true,
  ),
  MentorModel(
    user: mockUsers[2],
    expertise: const <String>['Brand', 'UI', 'Presentations'],
    isAvailable: false,
  ),
];
