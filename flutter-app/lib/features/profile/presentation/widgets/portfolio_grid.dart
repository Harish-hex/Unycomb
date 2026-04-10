import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/shared/models/project_model.dart';

class PortfolioGrid extends StatelessWidget {
  const PortfolioGrid({required this.projects, super.key});

  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (BuildContext context, int index) {
        final ProjectModel project = projects[index];
        return NexusCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(project.name, style: NexusTextStyles.subheading),
              const SizedBox(height: 4),
              Text(project.role, style: NexusTextStyles.caption),
              const Spacer(),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.techStack
                    .take(3)
                    .map(
                      (String tech) =>
                          NexusTag(label: tech, style: TagStyle.neutral),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
