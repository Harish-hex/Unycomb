import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/di/injection.dart';
import 'package:nexus/features/home/presentation/cubit/home_cubit.dart';
import 'package:nexus/features/home/presentation/widgets/grid_tile.dart';
import 'package:nexus/features/home/presentation/widgets/hero_zone.dart';
import 'package:nexus/features/home/presentation/widgets/nav_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.embeddedInShell = false});

  final bool embeddedInShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => getIt<HomeCubit>()..load(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (BuildContext context, HomeState state) {
              if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              if (state is! HomeLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<GridTileData> tiles = <GridTileData>[
                GridTileData(
                  label: 'Matching',
                  icon: Icons.person_search_rounded,
                  badge: '${state.matches}',
                  featured: true,
                  onTap: () => context.go('/shell/matching'),
                ),
                GridTileData(
                  label: 'Feed',
                  icon: Icons.bolt_rounded,
                  badge: '${state.hackathons}',
                  onTap: () => context.go('/shell/feed'),
                ),
                GridTileData(
                  label: 'Projects',
                  icon: Icons.folder_open_rounded,
                  badge: '${state.activeProjects}',
                  onTap: () => context.go('/projects'),
                ),
                GridTileData(
                  label: 'Mentorship',
                  icon: Icons.school_rounded,
                  onTap: () => context.go('/mentorship'),
                ),
                GridTileData(
                  label: 'Profile',
                  icon: Icons.account_circle_rounded,
                  badge: '88%',
                  onTap: () => context.go('/shell/profile'),
                ),
                GridTileData(
                  label: 'More',
                  icon: Icons.grid_view_rounded,
                  onTap: () => context.go('/shell/chat'),
                ),
              ];

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  embeddedInShell ? 8 : 16,
                  16,
                  16,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: HeroZone(
                        userName: state.userName,
                        activeProjects: state.activeProjects,
                        matches: state.matches,
                        hackathons: state.hackathons,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(child: NavGrid(tiles: tiles)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
