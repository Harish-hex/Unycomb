import 'package:nexus/shared/models/match_model.dart';

abstract class MatchingRepository {
  Future<List<MatchModel>> getMatches();
  Future<void> requestCollab(String userId);
}
