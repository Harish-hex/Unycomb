import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

enum TagStyle { accent, neutral }

class NexusTag extends StatefulWidget {
  const NexusTag({
    required this.label,
    super.key,
    this.style = TagStyle.neutral,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final TagStyle style;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<NexusTag> createState() => _NexusTagState();
}

class _NexusTagState extends State<NexusTag> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isAccent = widget.style == TagStyle.accent || widget.selected;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 1.05 : 1,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isAccent
                ? NexusColors.yellow.withValues(alpha: 0.15)
                : NexusColors.graphite,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isAccent
                  ? NexusColors.yellow.withValues(alpha: 0.35)
                  : NexusColors.ash,
            ),
          ),
          child: Text(
            widget.label,
            style: NexusTextStyles.caption.copyWith(
              color: isAccent ? NexusColors.yellow : NexusColors.warmGrey,
            ),
          ),
        ),
      ),
    );
  }
}
