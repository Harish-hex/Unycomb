import 'package:nexus/shared/models/opportunity_model.dart';

abstract class FeedRepository {
  Future<List<OpportunityModel>> getOpportunities();
}
