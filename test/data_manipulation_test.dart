import 'package:flutter_test/flutter_test.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/utils/data_manipulation.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';

void main() {
  var gpsFootprints = [
    GPSFootprint(0, 51.1, 21.1, DateTime(2020, 5, 1), 0),
    GPSFootprint(1, 51.1, 21.1, DateTime(2020, 2, 1), 2),
    GPSFootprint(2, 51.1, 21.1, DateTime(2020, 4, 1), 5),
    GPSFootprint(3, 51.1, 21.1, DateTime(2020, 1, 1), 4),
    GPSFootprint(4, 51.1, 21.1, DateTime(2020, 6, 1), 1),
    GPSFootprint(5, 51.1, 21.1, DateTime(2020, 3, 1), 3),
  ];

  group('Data manipulation -> Sorting:', () {
    test('Sorts data from newest to oldest', () {
      var sortedList = sortGPSFootprints(gpsFootprints.sublist(0), SortOptions.newest);
      expect(sortedList.map((e) => e.id), [4, 0, 2, 5, 1, 3]);
    });

    test('Sorts data from oldest to newest', () {
      var sortedList = sortGPSFootprints(gpsFootprints.sublist(0), SortOptions.oldest);
      expect(sortedList.map((e) => e.id), [3, 1, 5, 2, 0, 4]);
    });

    test('Sorts data by device ID (A->Z)', () {
      var sortedList = sortGPSFootprints(gpsFootprints.sublist(0), SortOptions.device_id_az);
      expect(sortedList.map((e) => e.id), [0, 4, 1, 5, 3, 2]);
    });

    test('Sorts data by device ID (Z->A)', () {
      var sortedList = sortGPSFootprints(gpsFootprints.sublist(0), SortOptions.device_id_za);
      expect(sortedList.map((e) => e.id), [2, 3, 5, 1, 4, 0]);
    });
  });

  group('Data manipulation -> Filtering:', () {
    test('Returns GPS footprints that was published after 2020-03-14', () {
      var filteredList = filterGPSFootprints(gpsFootprints, firstDate: DateTime(2020, 3, 14));
      expect(filteredList.map((e) => e.id), [0, 2, 4]);
    });

    test('Returns GPS footprints that was published before 2020-04-14', () {
      var filteredList = filterGPSFootprints(gpsFootprints, lastDate: DateTime(2020, 3, 14));
      expect(filteredList.map((e) => e.id), [1, 3, 5]);
    });

    test('Returns GPS footprints that was published between 2020-02-10 and 2020-05-14', () {
      var filteredList = filterGPSFootprints(
        gpsFootprints,
        firstDate: DateTime(2020, 2, 10),
        lastDate: DateTime(2020, 5, 14),
      );
      expect(filteredList.map((e) => e.id), [0, 2, 5]);
    });

    test('Returns GPS footprints that was published by device with ID = 2 or 4', () {
      var filteredList = filterGPSFootprints(gpsFootprints, selectedIDs: [2, 4]);
      expect(filteredList.map((e) => e.id), [1, 3]);
    });
  });
}
