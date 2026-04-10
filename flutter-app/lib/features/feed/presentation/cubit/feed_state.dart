part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => <Object?>[];
}

class FeedLoading extends FeedState {
  const FeedLoading();
}

class FeedLoaded extends FeedState {
  const FeedLoaded({
    required this.opportunities,
    required this.closingSoon,
    required this.activeCategory,
  });

  final List<OpportunityModel> opportunities;
  final List<OpportunityModel> closingSoon;
  final String activeCategory;

  @override
  List<Object?> get props => <Object?>[
        opportunities,
        closingSoon,
        activeCategory,
      ];
}

class FeedError extends FeedState {
  const FeedError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
