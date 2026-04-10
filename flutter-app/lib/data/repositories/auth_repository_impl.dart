import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nexus/domain/repositories/auth_repository.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required MockAppStore appStore,
    required FlutterSecureStorage secureStorage,
  })  : _appStore = appStore,
        _secureStorage = secureStorage;

  final MockAppStore _appStore;
  final FlutterSecureStorage _secureStorage;

  @override
  Stream<bool> get authStateChanges => _appStore.authStateChanges;

  @override
  bool get isAuthenticated => _appStore.isAuthenticated;

  @override
  String? get pendingEmail => _appStore.pendingEmail;

  @override
  Future<void> sendOtp(String email) async {
    await _appStore.sendOtp(email);
  }

  @override
  Future<void> signOut() async {
    await _secureStorage.delete(key: 'mock_token');
    await _appStore.signOut();
  }

  @override
  Future<void> verifyOtp(String code) async {
    await _appStore.verifyOtp(code);
    await _secureStorage.write(
      key: 'mock_token',
      value: 'student-session-token',
    );
  }
}
