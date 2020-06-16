import 'package:flutter_test/flutter_test.dart';
import 'package:gps_tracker_mobile/models/gps_footprint.dart';

void main() {
  group('GPS Footprint:', () {
    test('Class instance initializes from map data', () {
      var data = {
        'id': 1,
        'lat': 51.1,
        'lng': 21.2,
        'published_at': '2020-06-01 12:34:56.678',
        'device_id': 2,
      };
      var gpsFootprint = GPSFootprint.fromMap(data);
      expect(gpsFootprint.id, 1);
      expect(gpsFootprint.lat, 51.1);
      expect(gpsFootprint.lng, 21.2);
      expect(
        gpsFootprint.publishedAt.millisecondsSinceEpoch,
        DateTime(2020, 6, 1, 12, 34, 56, 678).millisecondsSinceEpoch,
      );
      expect(gpsFootprint.deviceID, 2);
    });
  });
}
