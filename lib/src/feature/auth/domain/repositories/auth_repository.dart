abstract class AuthRepository {
  Future<void> login(String phoneNumber, String password);
  Future<void> register(String phoneNumber, String password);
}
