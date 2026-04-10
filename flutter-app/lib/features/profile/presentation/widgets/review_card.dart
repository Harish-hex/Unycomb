import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/shared/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({required this.review, super.key});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return NexusCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              NexusAvatar(user: review.fromUser, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  review.fromUser.name,
                  style: NexusTextStyles.subheading,
                ),
              ),
              Text(
                review.rating.toStringAsFixed(1),
                style: NexusTextStyles.subheading.copyWith(
                  color: NexusColors.yellow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review.text, style: NexusTextStyles.body),
        ],
      ),
    );
  }
}
