import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/components/nexus_filter_chip.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/core/theme/colors.dart';
import 'package:nexus/core/theme/typography.dart';
import 'package:nexus/features/matching/presentation/cubit/matching_cubit.dart';
import 'package:nexus/features/matching/presentation/widgets/partner_card.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MatchingCubit>(
      create: (_) => getIt<MatchingCubit>()..loadMatches(),
      child: BlocListener<MatchingCubit, MatchingState>(
        listener: (BuildContext context, MatchingState state) {
          if (state is MatchRequestSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Collaboration request sent.')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Find partners'),
            actions: const <Widget>[Icon(Icons.filter_alt_outlined)],
          ),
          body: BlocBuilder<MatchingCubit, MatchingState>(
            builder: (BuildContext context, MatchingState state) {
              if (state is MatchingError) {
                return Center(child: Text(state.message));
              }
              if (state is! MatchingLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: NexusFilterChipRow(
                      labels: const <String>[
                        'All',
                        'Design',
                        'Backend',
                        'ML',
                        'Mobile',
                      ],
                      activeLabel: state.activeFilter,
                      onSelected: (String value) =>
                          context.read<MatchingCubit>().filterBySkill(value),
                    ),
                  ),
                  Expanded(
                    child: state.matches.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Icon(
                                  Icons.hive_outlined,
                                  size: 64,
                                  color: NexusColors.yellow,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No matches yet',
                                  style: NexusTextStyles.heading,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Update your skills to improve suggestions.',
                                  style: NexusTextStyles.body.copyWith(
                                    color: NexusColors.warmGrey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.matches.length,
                            itemBuilder: (BuildContext context, int index) {
                              final match = state.matches[index];
                              return PartnerCard(
                                match: match,
                                index: index,
                                onRequest: () => context
                                    .read<MatchingCubit>()
                                    .requestCollab(match.user.id),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
