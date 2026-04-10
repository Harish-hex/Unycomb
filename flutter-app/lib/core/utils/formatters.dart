import 'package:flutter/material.dart';

String formatRelativeSection(DateTime time) {
  final Duration difference = DateTime.now().difference(time);
  if (difference.inMinutes < 60) {
    return '${difference.inMinutes.clamp(1, 59)}m';
  }
  if (difference.inHours < 24) {
    return '${difference.inHours}h';
  }
  return '${difference.inDays}d';
}

String formatDeadline(DateTime dateTime) {
  final List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[dateTime.month - 1]} ${dateTime.day}';
}

Color statusColor(BuildContext context, bool isUrgent) {
  return isUrgent ? const Color(0xFFEF4444) : const Color(0xFFF5C518);
}
