import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';

class NexusCard extends StatefulWidget {
  const NexusCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.elevated = false,
    this.animationDelay = Duration.zero,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool elevated;
  final Duration animationDelay;

  @override
  State<NexusCard> createState() => _NexusCardState();
}

class _NexusCardState extends State<NexusCard> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.delayed(widget.animationDelay, () {
        if (mounted) {
          setState(() => _visible = true);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget card = AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.08),
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: NexusColors.carbon,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: NexusColors.ash),
            boxShadow: widget.elevated
                ? const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );

    return Padding(
      padding: widget.margin,
      child: widget.onTap == null
          ? card
          : InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: card,
            ),
    );
  }
}
