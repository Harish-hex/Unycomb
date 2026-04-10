import 'package:flutter/material.dart';

import 'package:nexus/core/components/nexus_badge.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class GridTileData {
  const GridTileData({
    required this.label,
    required this.icon,
    required this.onTap,
    this.badge,
    this.featured = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final String? badge;
  final bool featured;
}

class NexusGridTile extends StatefulWidget {
  const NexusGridTile({required this.data, super.key});

  final GridTileData data;

  @override
  State<NexusGridTile> createState() => _NexusGridTileState();
}

class _NexusGridTileState extends State<NexusGridTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.data.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.data.featured
                ? const Color(0xFF2A2410)
                : NexusColors.graphite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: NexusColors.ash),
          ),
          child: Stack(
            children: <Widget>[
              if (widget.data.featured)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: NexusColors.yellow,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(widget.data.icon, color: NexusColors.yellow, size: 24),
                  const Spacer(),
                  Text(widget.data.label, style: NexusTextStyles.subheading),
                ],
              ),
              if (widget.data.badge != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: NexusBadge(value: widget.data.badge!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
