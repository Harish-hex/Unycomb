part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => <Object?>[];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.user,
    required this.portfolio,
    required this.reviews,
  });

  final UserModel user;
  final List<ProjectModel> portfolio;
  final List<ReviewModel> reviews;

  @override
  List<Object?> get props => <Object?>[user, portfolio, reviews];
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
