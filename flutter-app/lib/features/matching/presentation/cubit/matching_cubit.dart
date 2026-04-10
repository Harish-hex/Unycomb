import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/matching_repository.dart';
import 'package:nexus/shared/models/match_model.dart';

part 'matching_state.dart';

class MatchingCubit extends Cubit<MatchingState> {
  MatchingCubit({required MatchingRepository matchingRepository})
      : _matchingRepository = matchingRepository,
        super(const MatchingLoading());

  final MatchingRepository _matchingRepository;
  List<MatchModel> _allMatches = <MatchModel>[];
  String _activeFilter = 'All';

  Future<void> loadMatches() async {
    emit(const MatchingLoading());
    try {
      _allMatches = await _matchingRepository.getMatches();
      emit(MatchingLoaded(matches: _filtered, activeFilter: _activeFilter));
    } catch (error) {
      emit(MatchingError(error.toString()));
    }
  }

  Future<void> filterBySkill(String skill) async {
    _activeFilter = skill;
    emit(MatchingLoaded(matches: _filtered, activeFilter: _activeFilter));
  }

  Future<void> requestCollab(String userId) async {
    try {
      await _matchingRepository.requestCollab(userId);
      _allMatches = await _matchingRepository.getMatches();
      emit(
        MatchRequestSent(
          matches: _filtered,
          activeFilter: _activeFilter,
          userId: userId,
        ),
      );
      emit(MatchingLoaded(matches: _filtered, activeFilter: _activeFilter));
    } catch (error) {
      emit(MatchingError(error.toString()));
    }
  }

  List<MatchModel> get _filtered {
    if (_activeFilter == 'All') {
      return _allMatches;
    }
    return _allMatches
        .where(
          (MatchModel match) => match.user.skills.any(
            (String skill) =>
                skill.toLowerCase().contains(_activeFilter.toLowerCase()),
          ),
        )
        .toList();
  }
}
