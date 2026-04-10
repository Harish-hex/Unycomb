import 'package:flutter/material.dart';

import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';

class NexusTheme {
  const NexusTheme._();

  static ThemeData get dark {
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: NexusColors.yellow,
      secondary: NexusColors.amberGold,
      surface: NexusColors.carbon,
      error: NexusColors.vermillion,
      onPrimary: NexusColors.black,
      onSecondary: NexusColors.black,
      onSurface: NexusColors.offWhite,
      onError: NexusColors.offWhite,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: NexusColors.black,
      colorScheme: colorScheme,
      textTheme: NexusTextStyles.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: NexusColors.offWhite,
        centerTitle: false,
      ),
      dividerColor: NexusColors.ash,
      cardTheme: CardThemeData(
        color: NexusColors.carbon,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: NexusColors.ash),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: NexusColors.carbon,
        selectedItemColor: NexusColors.yellow,
        unselectedItemColor: NexusColors.warmGrey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NexusColors.carbon,
        hintStyle: NexusTextStyles.body.copyWith(color: NexusColors.dim),
        labelStyle: NexusTextStyles.caption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: NexusColors.ash),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: NexusColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: NexusColors.yellow, width: 1.4),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: NexusColors.graphite,
        selectedColor: NexusColors.yellow,
        labelStyle: NexusTextStyles.caption,
        side: const BorderSide(color: NexusColors.ash),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}
