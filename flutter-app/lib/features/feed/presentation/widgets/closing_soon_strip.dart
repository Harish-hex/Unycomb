import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/core/utils/formatters.dart';
import 'package:nexus/shared/models/opportunity_model.dart';

class ClosingSoonStrip extends StatelessWidget {
  const ClosingSoonStrip({required this.items, super.key});

  final List<OpportunityModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final OpportunityModel item = items[index];
          return SizedBox(
            width: 240,
            child: NexusCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 32,
                    decoration: BoxDecoration(
                      color: NexusColors.yellow,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(item.title, style: NexusTextStyles.subheading),
                  const Spacer(),
                  Text(
                    'Closes ${formatDeadline(item.deadline)}',
                    style: NexusTextStyles.caption.copyWith(
                      color: NexusColors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
