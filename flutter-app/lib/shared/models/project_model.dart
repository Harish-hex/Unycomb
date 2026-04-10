import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/task_model.dart';
import 'package:nexus/shared/models/user_model.dart';

enum ProjectStatus { active, paused, completed }

class ProjectModel extends Equatable {
  const ProjectModel({
    required this.id,
    required this.name,
    required this.members,
    required this.progress,
    required this.openTaskCount,
    required this.status,
    required this.tasks,
    this.role = '',
    this.techStack = const <String>[],
  });

  final String id;
  final String name;
  final List<UserModel> members;
  final double progress;
  final int openTaskCount;
  final ProjectStatus status;
  final List<TaskModel> tasks;
  final String role;
  final List<String> techStack;

  ProjectModel copyWith({
    String? id,
    String? name,
    List<UserModel>? members,
    double? progress,
    int? openTaskCount,
    ProjectStatus? status,
    List<TaskModel>? tasks,
    String? role,
    List<String>? techStack,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      progress: progress ?? this.progress,
      openTaskCount: openTaskCount ?? this.openTaskCount,
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      role: role ?? this.role,
      techStack: techStack ?? this.techStack,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'members': members.map((UserModel user) => user.toJson()).toList(),
      'progress': progress,
      'openTaskCount': openTaskCount,
      'status': status.name,
      'tasks': tasks.map((TaskModel task) => task.toJson()).toList(),
      'role': role,
      'techStack': techStack,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      members: (json['members'] as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic item) => UserModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      openTaskCount: json['openTaskCount'] as int? ?? 0,
      status: ProjectStatus.values.firstWhere(
        (ProjectStatus value) => value.name == json['status'],
        orElse: () => ProjectStatus.active,
      ),
      tasks: (json['tasks'] as List<dynamic>? ?? <dynamic>[])
          .map(
            (dynamic item) => TaskModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      role: json['role'] as String? ?? '',
      techStack: List<String>.from(
        json['techStack'] as List<dynamic>? ?? <String>[],
      ),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        members,
        progress,
        openTaskCount,
        status,
        tasks,
        role,
        techStack,
      ];
}
