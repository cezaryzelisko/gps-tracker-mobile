class User {
  String accessToken;
  String refreshToken;

  User({this.accessToken, this.refreshToken});

  void fromMap(dynamic data) {
    accessToken = data['access'];
    refreshToken = data['refresh'];
  }
}
