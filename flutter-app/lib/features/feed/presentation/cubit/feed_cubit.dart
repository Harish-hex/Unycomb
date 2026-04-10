import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/feed_repository.dart';
import 'package:nexus/shared/models/opportunity_model.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit({required FeedRepository feedRepository})
      : _feedRepository = feedRepository,
        super(const FeedLoading());

  final FeedRepository _feedRepository;
  List<OpportunityModel> _all = <OpportunityModel>[];
  String _activeCategory = 'Hackathons';

  Future<void> loadFeed() async {
    emit(const FeedLoading());
    try {
      _all = await _feedRepository.getOpportunities();
      emit(
        FeedLoaded(
          opportunities: _filtered,
          closingSoon: _all
              .where((OpportunityModel item) => item.isClosingSoon)
              .toList(),
          activeCategory: _activeCategory,
        ),
      );
    } catch (error) {
      emit(FeedError(error.toString()));
    }
  }

  Future<void> filterByCategory(String category) async {
    _activeCategory = category;
    emit(
      FeedLoaded(
        opportunities: _filtered,
        closingSoon:
            _all.where((OpportunityModel item) => item.isClosingSoon).toList(),
        activeCategory: _activeCategory,
      ),
    );
  }

  List<OpportunityModel> get _filtered {
    final OpportunityType? type = switch (_activeCategory) {
      'Hackathons' => OpportunityType.hackathon,
      'Collabs' => OpportunityType.collab,
      'Competitions' => OpportunityType.competition,
      _ => null,
    };
    if (type == null) {
      return _all;
    }
    return _all.where((OpportunityModel item) => item.type == type).toList();
  }
}
