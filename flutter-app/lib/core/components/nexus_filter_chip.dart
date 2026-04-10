import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class NexusFilterChip extends StatelessWidget {
  const NexusFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? NexusColors.yellow : NexusColors.graphite,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: NexusTextStyles.caption.copyWith(
            color: isSelected ? NexusColors.black : NexusColors.warmGrey,
          ),
        ),
      ),
    );
  }
}

class NexusFilterChipRow extends StatelessWidget {
  const NexusFilterChipRow({
    required this.labels,
    required this.activeLabel,
    required this.onSelected,
    super.key,
  });

  final List<String> labels;
  final String activeLabel;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: labels
            .map(
              (String label) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: NexusFilterChip(
                  label: label,
                  isSelected: activeLabel == label,
                  onTap: () => onSelected(label),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
