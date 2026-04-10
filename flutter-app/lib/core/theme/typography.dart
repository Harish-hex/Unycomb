import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nexus/core/theme/colors.dart';

class NexusTextStyles {
  const NexusTextStyles._();

  static TextStyle get display => GoogleFonts.syne(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        color: NexusColors.offWhite,
      );

  static TextStyle get heading => GoogleFonts.syne(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: NexusColors.offWhite,
      );

  static TextStyle get subheading => GoogleFonts.syne(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: NexusColors.offWhite,
      );

  static TextStyle get body => GoogleFonts.dmSans(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w400,
        color: NexusColors.offWhite,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: NexusColors.warmGrey,
      );

  static TextStyle get code => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: NexusColors.offWhite,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: display,
        headlineMedium: heading,
        titleMedium: subheading,
        bodyMedium: body,
        bodySmall: caption,
        labelMedium: caption,
      );
}
