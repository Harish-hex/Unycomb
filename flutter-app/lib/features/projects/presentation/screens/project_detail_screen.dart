import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/di/injection.dart';
import 'package:nexus/features/projects/presentation/cubit/kanban_cubit.dart';
import 'package:nexus/features/projects/presentation/widgets/kanban_board.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KanbanCubit>(
      create: (_) => getIt<KanbanCubit>()..load(projectId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Project board')),
        body: BlocBuilder<KanbanCubit, KanbanState>(
          builder: (BuildContext context, KanbanState state) {
            if (state is KanbanError) {
              return Center(child: Text(state.message));
            }
            if (state is! KanbanLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: KanbanBoard(
                tasks: state.project.tasks,
                onMove: (String taskId, status) =>
                    context.read<KanbanCubit>().moveTask(
                          projectId: state.project.id,
                          taskId: taskId,
                          status: status,
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
