abstract class AuthRepository {
  bool get isAuthenticated;
  Stream<bool> get authStateChanges;
  String? get pendingEmail;

  Future<void> sendOtp(String email);
  Future<void> verifyOtp(String code);
  Future<void> signOut();
}
