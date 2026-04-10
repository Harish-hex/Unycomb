import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_badge.dart';
import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/utils/formatters.dart';
import 'package:nexus/shared/models/opportunity_model.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({required this.opportunity, super.key});

  final OpportunityModel opportunity;

  @override
  Widget build(BuildContext context) {
    return NexusCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: const Color(0xFFF5C518),
                foregroundColor: const Color(0xFF0D0D0D),
                child: Text(
                  opportunity.source.isEmpty ? '?' : opportunity.source[0],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  opportunity.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              NexusBadge(
                value: formatDeadline(opportunity.deadline),
                isUrgent: opportunity.isClosingSoon,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: opportunity.tags
                .map(
                  (String tag) => NexusTag(label: tag, style: TagStyle.neutral),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Text(opportunity.description, maxLines: 2),
          const SizedBox(height: 16),
          NexusButton.outlined(label: 'View', onTap: () {}),
        ],
      ),
    );
  }
}
