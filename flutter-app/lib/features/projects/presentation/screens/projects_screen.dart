import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:nexus/features/projects/presentation/widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsCubit>(
      create: (_) => getIt<ProjectsCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My projects'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: NexusButton.primary(
                  label: 'New project',
                  onTap: () {},
                  isExpanded: false,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (BuildContext context, ProjectsState state) {
            if (state is! ProjectsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state.projects
                  .map(
                    (project) => ProjectCard(
                      project: project,
                      onTap: () => context.push('/projects/${project.id}'),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
