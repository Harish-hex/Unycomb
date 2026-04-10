import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/shared/mock/mock_data.dart';

class HeroZone extends StatelessWidget {
  const HeroZone({
    required this.userName,
    required this.activeProjects,
    required this.matches,
    required this.hackathons,
    super.key,
  });

  final String userName;
  final int activeProjects;
  final int matches;
  final int hackathons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: NexusColors.carbon,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: NexusColors.ash),
        gradient: const LinearGradient(
          colors: <Color>[NexusColors.carbon, Color(0xFF151515)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: IgnorePointer(
              child: Wrap(
                spacing: 14,
                runSpacing: 14,
                children: List<Widget>.generate(
                  30,
                  (_) => Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: NexusColors.yellow.withValues(alpha: 0.04),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'NEXUS',
                    style: NexusTextStyles.heading.copyWith(
                      color: NexusColors.yellow,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none_rounded),
                  const SizedBox(width: 12),
                  NexusAvatar(user: mockCurrentUser, size: 40),
                ],
              ),
              const Spacer(),
              Text('Good morning, $userName', style: NexusTextStyles.heading),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _StatPill(label: '$activeProjects active projects'),
                    _StatPill(label: '$matches new matches'),
                    _StatPill(label: '$hackathons hackathons'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: NexusColors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: NexusColors.ash),
      ),
      child: Text(label, style: NexusTextStyles.caption),
    );
  }
}
