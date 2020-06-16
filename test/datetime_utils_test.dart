import 'package:flutter_test/flutter_test.dart';
import 'package:gps_tracker_mobile/utils/datetime_utils.dart';

main() {
  group('DateTime Utils:', () {
    var dateTime = DateTime(2020, 6, 16, 12, 34, 56, 789);
    test('Prints only date', () {
      var formattedString = formatDateTime(dateTime, withDate: true, withTime: false, withMillis: false);
      expect(formattedString, '2020-06-16');
    });

    test('Prints only time', () {
      var formattedString = formatDateTime(dateTime, withDate: false, withTime: true, withMillis: false);
      expect(formattedString, '12:34:56');
    });

    test('Prints only milliseconds', () {
      var formattedString = formatDateTime(dateTime, withDate: false, withTime: false, withMillis: true);
      expect(formattedString, '789');
    });

    test('Prints date and time without milliseconds', () {
      var formattedString = formatDateTime(dateTime, withDate: true, withTime: true, withMillis: false);
      expect(formattedString, '2020-06-16 12:34:56');
    });

    test('Prints date and time', () {
      var formattedString = formatDateTime(dateTime, withDate: true, withTime: true, withMillis: true);
      expect(formattedString, '2020-06-16 12:34:56.789');
    });
  });
}
