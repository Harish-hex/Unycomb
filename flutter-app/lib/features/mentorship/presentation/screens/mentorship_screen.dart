import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/components/nexus_avatar.dart';
import 'package:nexus/core/components/nexus_button.dart';
import 'package:nexus/core/components/nexus_card.dart';
import 'package:nexus/core/components/nexus_tag.dart';
import 'package:nexus/core/di/injection.dart';
import 'package:nexus/features/mentorship/presentation/cubit/mentorship_cubit.dart';

class MentorshipScreen extends StatelessWidget {
  const MentorshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MentorshipCubit>(
      create: (_) => getIt<MentorshipCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Mentorship')),
        body: BlocBuilder<MentorshipCubit, MentorshipState>(
          builder: (BuildContext context, MentorshipState state) {
            if (state is! MentorshipLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state.mentors.map((mentor) {
                return NexusCard(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          NexusAvatar(user: mentor.user),
                          const SizedBox(width: 12),
                          Expanded(child: Text(mentor.user.name)),
                          Text(mentor.isAvailable ? 'Available' : 'Booked'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: mentor.expertise
                            .map(
                              (String item) =>
                                  NexusTag(label: item, style: TagStyle.accent),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      NexusButton.primary(
                        label: 'Request session',
                        onTap: mentor.isAvailable ? () {} : null,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
