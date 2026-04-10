import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/components/nexus_filter_chip.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:nexus/features/feed/presentation/widgets/closing_soon_strip.dart';
import 'package:nexus/features/feed/presentation/widgets/opportunity_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedCubit>(
      create: (_) => getIt<FeedCubit>()..loadFeed(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Opportunities')),
        body: BlocBuilder<FeedCubit, FeedState>(
          builder: (BuildContext context, FeedState state) {
            if (state is FeedError) {
              return Center(child: Text(state.message));
            }
            if (state is! FeedLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Text('Closing soon', style: NexusTextStyles.heading),
                const SizedBox(height: 12),
                ClosingSoonStrip(items: state.closingSoon.take(3).toList()),
                const SizedBox(height: 20),
                NexusFilterChipRow(
                  labels: const <String>[
                    'Hackathons',
                    'Collabs',
                    'Competitions',
                  ],
                  activeLabel: state.activeCategory,
                  onSelected: (String value) =>
                      context.read<FeedCubit>().filterByCategory(value),
                ),
                const SizedBox(height: 16),
                ...state.opportunities.map(
                  (opportunity) => OpportunityCard(opportunity: opportunity),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
