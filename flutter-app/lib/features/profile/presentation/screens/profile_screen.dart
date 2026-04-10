import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nexus/features/profile/presentation/widgets/portfolio_grid.dart';
import 'package:nexus/features/profile/presentation/widgets/reputation_badge.dart';
import 'package:nexus/features/profile/presentation/widgets/review_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: <Widget>[
            TextButton(
              onPressed: () => context.push('/reviews'),
              child: const Text('Reviews'),
            ),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            if (state is! ProfileLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    NexusAvatar(user: state.user, size: 80),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  state.user.name,
                                  style: NexusTextStyles.heading,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.verified_rounded,
                                color: NexusColors.yellow,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${state.user.university} • ${state.user.year}',
                            style: NexusTextStyles.body.copyWith(
                              color: NexusColors.warmGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ReputationBadge(
                  score: state.user.reputationScore,
                  reviewCount: state.user.reviewCount,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.user.skills
                      .map(
                        (String skill) =>
                            NexusTag(label: skill, style: TagStyle.accent),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                Text('Portfolio', style: NexusTextStyles.heading),
                const SizedBox(height: 12),
                PortfolioGrid(projects: state.portfolio),
                const SizedBox(height: 24),
                Text('Reviews', style: NexusTextStyles.heading),
                const SizedBox(height: 12),
                ...state.reviews.map((review) => ReviewCard(review: review)),
              ],
            );
          },
        ),
      ),
    );
  }
}
