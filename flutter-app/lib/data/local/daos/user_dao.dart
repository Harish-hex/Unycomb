import 'package:nexus/shared/models/user_model.dart';

class UserDao {
  UserModel? _cachedUser;

  Future<void> save(UserModel user) async {
    _cachedUser = user;
  }

  Future<UserModel?> fetch() async {
    return _cachedUser;
  }
}
