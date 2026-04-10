import 'package:equatable/equatable.dart';

import 'package:nexus/shared/models/user_model.dart';

enum TaskStatus { todo, inProgress, done }

class TaskModel extends Equatable {
  const TaskModel({
    required this.id,
    required this.title,
    required this.assignee,
    required this.dueDate,
    required this.status,
  });

  final String id;
  final String title;
  final UserModel assignee;
  final DateTime dueDate;
  final TaskStatus status;

  TaskModel copyWith({
    String? id,
    String? title,
    UserModel? assignee,
    DateTime? dueDate,
    TaskStatus? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      assignee: assignee ?? this.assignee,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'assignee': assignee.toJson(),
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      assignee: UserModel.fromJson(json['assignee'] as Map<String, dynamic>),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: TaskStatus.values.firstWhere(
        (TaskStatus value) => value.name == json['status'],
        orElse: () => TaskStatus.todo,
      ),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, title, assignee, dueDate, status];
}
