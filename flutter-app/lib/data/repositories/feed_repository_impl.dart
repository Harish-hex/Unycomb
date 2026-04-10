import 'package:nexus/data/local/daos/opportunity_dao.dart';
import 'package:nexus/domain/repositories/feed_repository.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/opportunity_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl({
    required MockAppStore appStore,
    required OpportunityDao opportunityDao,
  })  : _appStore = appStore,
        _opportunityDao = opportunityDao;

  final MockAppStore _appStore;
  final OpportunityDao _opportunityDao;

  @override
  Future<List<OpportunityModel>> getOpportunities() async {
    final List<OpportunityModel> items = _appStore.opportunities;
    await _opportunityDao.saveAll(items);
    return items;
  }
}
