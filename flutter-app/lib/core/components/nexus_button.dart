import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

enum NexusButtonVariant { primary, outlined, ghost }

class NexusButton extends StatefulWidget {
  const NexusButton._({
    required this.label,
    required this.onTap,
    required this.variant,
    this.isLoading = false,
    this.isDisabled = false,
    this.isExpanded = true,
    this.icon,
  });

  factory NexusButton.primary({
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
    bool isDisabled = false,
    bool isExpanded = true,
    Widget? icon,
  }) {
    return NexusButton._(
      label: label,
      onTap: onTap,
      variant: NexusButtonVariant.primary,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isExpanded: isExpanded,
      icon: icon,
    );
  }

  factory NexusButton.outlined({
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
    bool isDisabled = false,
    bool isExpanded = true,
    Widget? icon,
  }) {
    return NexusButton._(
      label: label,
      onTap: onTap,
      variant: NexusButtonVariant.outlined,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isExpanded: isExpanded,
      icon: icon,
    );
  }

  factory NexusButton.ghost({
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
    bool isDisabled = false,
    bool isExpanded = false,
    Widget? icon,
  }) {
    return NexusButton._(
      label: label,
      onTap: onTap,
      variant: NexusButtonVariant.ghost,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isExpanded: isExpanded,
      icon: icon,
    );
  }

  final String label;
  final VoidCallback? onTap;
  final NexusButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final bool isExpanded;
  final Widget? icon;

  @override
  State<NexusButton> createState() => _NexusButtonState();
}

class _NexusButtonState extends State<NexusButton> {
  bool _pressed = false;

  bool get _enabled =>
      !widget.isDisabled && !widget.isLoading && widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = switch (widget.variant) {
      NexusButtonVariant.primary => FilledButton.styleFrom(
          backgroundColor: NexusColors.yellow,
          foregroundColor: NexusColors.black,
          disabledBackgroundColor: NexusColors.yellow.withValues(alpha: 0.35),
          textStyle: NexusTextStyles.subheading.copyWith(
            color: NexusColors.black,
          ),
          minimumSize: const Size.fromHeight(48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      NexusButtonVariant.outlined => OutlinedButton.styleFrom(
          foregroundColor: NexusColors.yellow,
          side: const BorderSide(color: NexusColors.yellow),
          textStyle: NexusTextStyles.subheading.copyWith(
            color: NexusColors.yellow,
          ),
          minimumSize: const Size.fromHeight(48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      NexusButtonVariant.ghost => TextButton.styleFrom(
          foregroundColor: NexusColors.warmGrey,
          textStyle: NexusTextStyles.subheading.copyWith(
            color: NexusColors.warmGrey,
          ),
          minimumSize: const Size(0, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
    };

    final Widget child = AnimatedScale(
      scale: _pressed ? 0.96 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
        onTapCancel: _enabled ? () => setState(() => _pressed = false) : null,
        onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
        child: switch (widget.variant) {
          NexusButtonVariant.primary => FilledButton(
              onPressed: _enabled ? widget.onTap : null,
              style: style,
              child: _ButtonContent(widget: widget),
            ),
          NexusButtonVariant.outlined => OutlinedButton(
              onPressed: _enabled ? widget.onTap : null,
              style: style,
              child: _ButtonContent(widget: widget),
            ),
          NexusButtonVariant.ghost => TextButton(
              onPressed: _enabled ? widget.onTap : null,
              style: style,
              child: _ButtonContent(widget: widget),
            ),
        },
      ),
    );

    return widget.isExpanded
        ? SizedBox(width: double.infinity, child: child)
        : child;
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({required this.widget});

  final NexusButton widget;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2.2),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.icon != null) ...<Widget>[
          widget.icon!,
          const SizedBox(width: 8),
        ],
        Text(widget.label),
      ],
    );
  }
}
