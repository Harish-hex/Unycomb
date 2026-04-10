part of 'matching_cubit.dart';

abstract class MatchingState extends Equatable {
  const MatchingState();

  @override
  List<Object?> get props => <Object?>[];
}

class MatchingLoading extends MatchingState {
  const MatchingLoading();
}

class MatchingLoaded extends MatchingState {
  const MatchingLoaded({required this.matches, required this.activeFilter});

  final List<MatchModel> matches;
  final String activeFilter;

  @override
  List<Object?> get props => <Object?>[matches, activeFilter];
}

class MatchRequestSent extends MatchingLoaded {
  const MatchRequestSent({
    required super.matches,
    required super.activeFilter,
    required this.userId,
  });

  final String userId;

  @override
  List<Object?> get props => <Object?>[...super.props, userId];
}

class MatchingError extends MatchingState {
  const MatchingError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
