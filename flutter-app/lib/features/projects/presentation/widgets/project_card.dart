import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/shared/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, required this.onTap, super.key});

  final ProjectModel project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NexusCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(project.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          NexusAvatarStack(members: project.members),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: project.progress,
            backgroundColor: NexusColors.graphite,
            color: NexusColors.yellow,
          ),
          const SizedBox(height: 8),
          Text('${project.openTaskCount} open tasks'),
        ],
      ),
    );
  }
}
