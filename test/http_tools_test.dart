import 'package:flutter_test/flutter_test.dart';

import 'package:gps_tracker_mobile/utils/http_tools.dart';

void main() {
  group('HTTP Tools -> URL formatting:', () {
    test('Returns properly formatted API URL', () {
      var url = getUrl('api', 'gps_footprint');
      expect(url, 'http://192.168.1.102:8000/api/gps-footprint/');
    });

    test('Returns properly formatted Auth URL', () {
      var url = getUrl('auth', 'refresh_token');
      expect(url, 'http://192.168.1.102:8000/auth/token/refresh/');
    });
  });
}
