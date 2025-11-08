abstract interface class UserDataSource {
  /// [accessToken]
  String get accessToken;
  Future<void> setAccessToken(String accessToken);

  /// [refreshToken]
  String get refreshToken;
  Future<void> setRefreshToken(String refreshToken);

  bool get isUserAuthenticated;
}
