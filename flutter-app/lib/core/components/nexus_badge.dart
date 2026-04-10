import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class NexusBadge extends StatelessWidget {
  const NexusBadge({required this.value, super.key, this.isUrgent = false});

  final String value;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isUrgent ? NexusColors.vermillion : NexusColors.yellow,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: NexusTextStyles.caption.copyWith(
          color: isUrgent ? NexusColors.offWhite : NexusColors.black,
        ),
      ),
    );
  }
}
