import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/review_model.dart';
import 'package:nexus/shared/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getCurrentUser();
  Future<void> saveProfile({
    required String name,
    required String year,
    required List<String> skills,
    String? avatarUrl,
  });
  Future<List<ReviewModel>> getReviewsForUser(String userId);
  Future<List<ProjectModel>> getPortfolioProjects(String userId);
}
