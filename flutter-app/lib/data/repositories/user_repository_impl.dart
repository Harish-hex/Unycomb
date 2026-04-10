import 'package:nexus/data/local/daos/user_dao.dart';
import 'package:nexus/domain/repositories/user_repository.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/review_model.dart';
import 'package:nexus/shared/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required MockAppStore appStore, required UserDao userDao})
      : _appStore = appStore,
        _userDao = userDao;

  final MockAppStore _appStore;
  final UserDao _userDao;

  @override
  Future<UserModel> getCurrentUser() async {
    final UserModel? cached = await _userDao.fetch();
    if (cached != null) {
      return cached;
    }
    final UserModel current = _appStore.currentUser;
    await _userDao.save(current);
    return current;
  }

  @override
  Future<List<ProjectModel>> getPortfolioProjects(String userId) async {
    return _appStore.projects;
  }

  @override
  Future<List<ReviewModel>> getReviewsForUser(String userId) async {
    return _appStore.reviews;
  }

  @override
  Future<void> saveProfile({
    required String name,
    required String year,
    required List<String> skills,
    String? avatarUrl,
  }) async {
    await _appStore.saveProfile(
      name: name,
      year: year,
      skills: skills,
      avatarUrl: avatarUrl,
    );
    await _userDao.save(_appStore.currentUser);
  }
}
