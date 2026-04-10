import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class NexusBottomNavItem {
  const NexusBottomNavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class NexusBottomNav extends StatelessWidget {
  const NexusBottomNav({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final List<NexusBottomNavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: NexusColors.carbon,
        border: Border(top: BorderSide(color: NexusColors.ash)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      child: Row(
        children: items.asMap().entries.map((entry) {
          final bool active = entry.key == currentIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(entry.key),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(
                  top: active ? 4 : 8,
                  bottom: active ? 0 : 8,
                ),
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  offset: active ? Offset.zero : const Offset(0, 0.08),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        entry.value.icon,
                        color:
                            active ? NexusColors.yellow : NexusColors.warmGrey,
                      ),
                      const SizedBox(height: 4),
                      AnimatedOpacity(
                        opacity: active ? 1 : 0,
                        duration: const Duration(milliseconds: 160),
                        child: Text(
                          entry.value.label,
                          style: NexusTextStyles.caption.copyWith(
                            color: NexusColors.yellow,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedOpacity(
                        opacity: active ? 1 : 0,
                        duration: const Duration(milliseconds: 160),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: NexusColors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
