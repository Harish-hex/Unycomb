part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => <Object?>[];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.userName,
    required this.activeProjects,
    required this.matches,
    required this.hackathons,
  });

  final String userName;
  final int activeProjects;
  final int matches;
  final int hackathons;

  @override
  List<Object?> get props => <Object?>[
        userName,
        activeProjects,
        matches,
        hackathons,
      ];
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
