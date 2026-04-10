import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/shared/models/match_model.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    required this.match,
    required this.onRequest,
    required this.index,
    super.key,
  });

  final MatchModel match;
  final VoidCallback onRequest;
  final int index;

  @override
  Widget build(BuildContext context) {
    return NexusCard(
      animationDelay: Duration(milliseconds: 60 * index),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              NexusAvatar(user: match.user),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(match.user.name, style: NexusTextStyles.subheading),
                    Text(match.user.university, style: NexusTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: match.user.skills
                .map(
                  (String skill) =>
                      NexusTag(label: skill, style: TagStyle.accent),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Text(match.bio, style: NexusTextStyles.body, maxLines: 2),
          const SizedBox(height: 16),
          NexusButton.primary(
            label: match.matchStatus == MatchStatus.requested
                ? 'Request sent'
                : 'Request collab',
            onTap:
                match.matchStatus == MatchStatus.requested ? null : onRequest,
          ),
        ],
      ),
    );
  }
}
