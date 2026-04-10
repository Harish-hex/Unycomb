import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class ReputationBadge extends StatelessWidget {
  const ReputationBadge({
    required this.score,
    required this.reviewCount,
    super.key,
  });

  final double score;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NexusColors.carbon,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: NexusColors.ash),
      ),
      child: Row(
        children: <Widget>[
          Text(
            score.toStringAsFixed(1),
            style: NexusTextStyles.display.copyWith(
              color: NexusColors.yellow,
              fontSize: 36,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: List<Widget>.generate(
                  5,
                  (int index) => const Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: NexusColors.yellow,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text('$reviewCount collaborator reviews'),
            ],
          ),
        ],
      ),
    );
  }
}
