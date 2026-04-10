import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/navigation/app_router.dart';
import 'package:nexus/core/theme/theme.dart';

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.instance.router;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: NexusTheme.dark,
      routerConfig: router,
    );
  }
}
