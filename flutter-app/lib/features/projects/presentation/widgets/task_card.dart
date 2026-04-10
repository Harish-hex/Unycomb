import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/utils/formatters.dart';
import 'package:nexus/shared/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return NexusCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(task.title),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              NexusAvatar(user: task.assignee, size: 28),
              const Spacer(),
              Text(formatDeadline(task.dueDate)),
            ],
          ),
        ],
      ),
    );
  }
}
