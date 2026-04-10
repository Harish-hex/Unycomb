import 'package:nexus/domain/repositories/matching_repository.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/match_model.dart';

class MatchingRepositoryImpl implements MatchingRepository {
  MatchingRepositoryImpl({required MockAppStore appStore})
      : _appStore = appStore;

  final MockAppStore _appStore;

  @override
  Future<List<MatchModel>> getMatches() async {
    return _appStore.matches;
  }

  @override
  Future<void> requestCollab(String userId) async {
    await _appStore.requestCollab(userId);
  }
}
