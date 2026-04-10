import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexus/core/di/injection.dart';
import 'package:nexus/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:nexus/features/profile/presentation/widgets/review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..load(),
      child: Scaffold(
        appBar: AppBar(title: const Text('All reviews')),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            if (state is! ProfileLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state.reviews
                  .map((review) => ReviewCard(review: review))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
