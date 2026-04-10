import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/features/projects/presentation/widgets/task_card.dart';
import 'package:nexus/shared/models/task_model.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({required this.tasks, required this.onMove, super.key});

  final List<TaskModel> tasks;
  final void Function(String taskId, TaskStatus status) onMove;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool horizontal = constraints.maxWidth > 720;
        final List<Widget> columns = TaskStatus.values.map((TaskStatus status) {
          final List<TaskModel> columnTasks =
              tasks.where((TaskModel task) => task.status == status).toList();
          return SizedBox(
            width: horizontal ? 280 : double.infinity,
            child: NexusCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(switch (status) {
                    TaskStatus.todo => 'To do',
                    TaskStatus.inProgress => 'In progress',
                    TaskStatus.done => 'Done',
                  }),
                  const SizedBox(height: 12),
                  ...columnTasks.map((TaskModel task) {
                    return Column(
                      children: <Widget>[
                        TaskCard(task: task),
                        Wrap(
                          spacing: 6,
                          children: TaskStatus.values
                              .where((TaskStatus item) => item != status)
                              .map(
                                (TaskStatus target) => ActionChip(
                                  backgroundColor: NexusColors.graphite,
                                  label: Text(target.name),
                                  onPressed: () => onMove(task.id, target),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        }).toList();

        return horizontal
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columns
                      .map(
                        (Widget column) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: column,
                        ),
                      )
                      .toList(),
                ),
              )
            : ListView.separated(
                itemCount: columns.length,
                itemBuilder: (BuildContext context, int index) =>
                    columns[index],
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              );
      },
    );
  }
}
