class User {
  String accessToken;
  String refreshToken;
  DateTime accessExpirationDate;
  DateTime refreshExpirationDate;

  User(
    this.accessToken,
    this.refreshToken,
    this.accessExpirationDate,
    this.refreshExpirationDate,
  );

  User.empty();

  void fromMap(dynamic data) {
    accessToken = data['access'];
    refreshToken = data['refresh'];
    accessExpirationDate = DateTime.fromMillisecondsSinceEpoch(data['accessExpiresAt'].toInt() * 1000);
    refreshExpirationDate = DateTime.fromMillisecondsSinceEpoch(data['refreshExpiresAt'].toInt() * 1000);
  }

  bool isLoggedIn() => accessToken != null && accessExpirationDate.isAfter(DateTime.now());

  bool isRefreshTokenValid() => refreshToken != null && refreshExpirationDate.isAfter(DateTime.now());
}
