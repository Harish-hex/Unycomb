import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/shared/models/user_model.dart';

class NexusAvatar extends StatelessWidget {
  const NexusAvatar({required this.user, super.key, this.size = 52});

  final UserModel user;
  final double size;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(size / 2);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: NexusColors.graphite,
        borderRadius: radius,
        border: Border.all(color: NexusColors.ash),
      ),
      clipBehavior: Clip.antiAlias,
      child: user.avatarUrl.isNotEmpty
          ? CachedNetworkImage(imageUrl: user.avatarUrl, fit: BoxFit.cover)
          : Center(
              child: Text(
                user.initials,
                style: NexusTextStyles.subheading.copyWith(
                  color: NexusColors.yellow,
                ),
              ),
            ),
    );
  }
}

class NexusAvatarStack extends StatelessWidget {
  const NexusAvatarStack({required this.members, super.key, this.size = 32});

  final List<UserModel> members;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: members.take(3).length * (size * 0.64) + size * 0.36,
      child: Stack(
        children: members.take(3).toList().asMap().entries.map((entry) {
          return Positioned(
            left: entry.key * (size * 0.64),
            child: NexusAvatar(user: entry.value, size: size),
          );
        }).toList(),
      ),
    );
  }
}
