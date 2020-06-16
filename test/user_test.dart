import 'package:flutter_test/flutter_test.dart';

import 'package:gps_tracker_mobile/models/user.dart';

void main() {
  group('User:', () {
    var data = {
      'access': 'access_token',
      'refresh': 'refresh_token',
      'accessExpiresAt': 1592301872,
      'refreshExpiresAt': 1592301882,
    };

    test('User initializes from map data', () {
      var user = User.empty();
      user.fromMap(data);
      expect(user.accessToken, 'access_token');
      expect(user.refreshToken, 'refresh_token');
      expect(user.accessExpirationDate.millisecondsSinceEpoch, 1592301872000);
      expect(user.refreshExpirationDate.millisecondsSinceEpoch, 1592301882000);
    });

    test('User is not logged in (access token is null)', () {
      var user = User.empty();
      expect(user.isLoggedIn(), false);
    });

    test('User is not logged in (access token has expired)', () {
      var user = User.empty();
      user.fromMap(data);
      expect(user.isLoggedIn(), false);
    });

    test('Refresh token is not valid (refresh token is null)', () {
      var user = User.empty();
      expect(user.isRefreshTokenValid(), false);
    });

    test('Refresh token is not valid (refresh token has expired)', () {
      var user = User.empty();
      user.fromMap(data);
      expect(user.isRefreshTokenValid(), false);
    });
  });
}
