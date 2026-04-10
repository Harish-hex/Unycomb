import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nexus/domain/repositories/feed_repository.dart';
import 'package:nexus/domain/repositories/matching_repository.dart';
import 'package:nexus/domain/repositories/project_repository.dart';
import 'package:nexus/domain/repositories/user_repository.dart';
import 'package:nexus/shared/models/match_model.dart';
import 'package:nexus/shared/models/opportunity_model.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required UserRepository userRepository,
    required MatchingRepository matchingRepository,
    required FeedRepository feedRepository,
    required ProjectRepository projectRepository,
  })  : _userRepository = userRepository,
        _matchingRepository = matchingRepository,
        _feedRepository = feedRepository,
        _projectRepository = projectRepository,
        super(const HomeLoading());

  final UserRepository _userRepository;
  final MatchingRepository _matchingRepository;
  final FeedRepository _feedRepository;
  final ProjectRepository _projectRepository;

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final UserModel user = await _userRepository.getCurrentUser();
      final List<MatchModel> matches = await _matchingRepository.getMatches();
      final List<OpportunityModel> opportunities =
          await _feedRepository.getOpportunities();
      final List<ProjectModel> projects =
          await _projectRepository.getProjects();
      emit(
        HomeLoaded(
          userName: user.name,
          activeProjects: projects.length,
          matches: matches
              .where(
                (MatchModel item) => item.matchStatus != MatchStatus.connected,
              )
              .length,
          hackathons: opportunities
              .where(
                (OpportunityModel item) =>
                    item.type == OpportunityType.hackathon,
              )
              .length,
        ),
      );
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}
