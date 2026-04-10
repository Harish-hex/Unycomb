import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_bottom_nav.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/navigation/go_router_refresh_stream.dart';
import 'package:nexus/domain/repositories/auth_repository.dart';
import 'package:nexus/features/chat/presentation/screens/chat_detail_screen.dart';
import 'package:nexus/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:nexus/features/feed/presentation/screens/feed_screen.dart';
import 'package:nexus/features/home/presentation/screens/home_screen.dart';
import 'package:nexus/features/matching/presentation/screens/matching_screen.dart';
import 'package:nexus/features/mentorship/presentation/screens/mentorship_screen.dart';
import 'package:nexus/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:nexus/features/onboarding/presentation/screens/profile_setup_screen.dart';
import 'package:nexus/features/onboarding/presentation/screens/verify_screen.dart';
import 'package:nexus/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:nexus/features/profile/presentation/screens/profile_screen.dart';
import 'package:nexus/features/profile/presentation/screens/reviews_screen.dart';
import 'package:nexus/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:nexus/features/projects/presentation/screens/projects_screen.dart';

class AppRouter {
  AppRouter._() : _router = _buildRouter();

  static final AppRouter instance = AppRouter._();

  late final GoRouter _router;

  static GoRouter _buildRouter() {
    final AuthRepository authRepository = getIt<AuthRepository>();
    return GoRouter(
      initialLocation: '/onboarding',
      refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
      redirect: (BuildContext context, GoRouterState state) {
        final bool isOnboarding =
            state.matchedLocation.startsWith('/onboarding');
        if (!authRepository.isAuthenticated && !isOnboarding) {
          return '/onboarding';
        }
        if (authRepository.isAuthenticated &&
            state.matchedLocation == '/onboarding') {
          return '/home';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/onboarding',
          builder: (_, __) => const WelcomeScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: 'verify',
              builder: (_, __) => BlocProvider<OnboardingCubit>(
                create: (_) => getIt<OnboardingCubit>(),
                child: const VerifyScreen(),
              ),
            ),
            GoRoute(
              path: 'profile-setup',
              builder: (_, __) => BlocProvider<OnboardingCubit>(
                create: (_) => getIt<OnboardingCubit>(),
                child: const ProfileSetupScreen(),
              ),
            ),
          ],
        ),
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return _ShellScaffold(
              child: child,
              location: state.matchedLocation,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/shell/home',
              builder: (_, __) => const HomeScreen(embeddedInShell: true),
            ),
            GoRoute(
              path: '/shell/matching',
              builder: (_, __) => const MatchingScreen(),
            ),
            GoRoute(
              path: '/shell/feed',
              builder: (_, __) => const FeedScreen(),
            ),
            GoRoute(
              path: '/shell/chat',
              builder: (_, __) => const ChatListScreen(),
            ),
            GoRoute(
              path: '/shell/profile',
              builder: (_, __) => const ProfileScreen(),
            ),
          ],
        ),
        GoRoute(path: '/projects', builder: (_, __) => const ProjectsScreen()),
        GoRoute(
          path: '/projects/:id',
          builder: (_, GoRouterState state) =>
              ProjectDetailScreen(projectId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: '/mentorship',
          builder: (_, __) => const MentorshipScreen(),
        ),
        GoRoute(
          path: '/chat/:id',
          builder: (_, GoRouterState state) =>
              ChatDetailScreen(conversationId: state.pathParameters['id']!),
        ),
        GoRoute(path: '/reviews', builder: (_, __) => const ReviewsScreen()),
      ],
    );
  }

  GoRouter get router => _router;
}

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold({required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context) {
    const List<String> destinations = <String>[
      '/shell/home',
      '/shell/matching',
      '/shell/feed',
      '/shell/chat',
      '/shell/profile',
    ];
    final int index = destinations.indexWhere(
      (String path) => location.startsWith(path),
    );
    return Scaffold(
      body: child,
      bottomNavigationBar: NexusBottomNav(
        currentIndex: index < 0 ? 0 : index,
        items: const <NexusBottomNavItem>[
          NexusBottomNavItem(label: 'Home', icon: Icons.home_rounded),
          NexusBottomNavItem(label: 'Match', icon: Icons.person_search_rounded),
          NexusBottomNavItem(label: 'Feed', icon: Icons.bolt_rounded),
          NexusBottomNavItem(
            label: 'Chat',
            icon: Icons.chat_bubble_outline_rounded,
          ),
          NexusBottomNavItem(
            label: 'Profile',
            icon: Icons.account_circle_rounded,
          ),
        ],
        onTap: (int newIndex) => context.go(destinations[newIndex]),
      ),
    );
  }
}
