import 'package:nexus/shared/models/opportunity_model.dart';

class OpportunityDao {
  List<OpportunityModel> _items = <OpportunityModel>[];

  Future<void> saveAll(List<OpportunityModel> items) async {
    _items = List<OpportunityModel>.from(items);
  }

  Future<List<OpportunityModel>> fetchAll() async {
    return List<OpportunityModel>.from(_items);
  }
}
