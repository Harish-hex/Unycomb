import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/user_repository.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/review_model.dart';
import 'package:nexus/shared/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ProfileLoading());

  final UserRepository _userRepository;

  Future<void> load() async {
    emit(const ProfileLoading());
    try {
      final UserModel user = await _userRepository.getCurrentUser();
      final List<ProjectModel> portfolio =
          await _userRepository.getPortfolioProjects(user.id);
      final List<ReviewModel> reviews = await _userRepository.getReviewsForUser(
        user.id,
      );
      emit(ProfileLoaded(user: user, portfolio: portfolio, reviews: reviews));
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
