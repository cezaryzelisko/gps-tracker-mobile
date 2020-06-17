import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/gps_list_item.dart';
import 'package:gps_tracker_mobile/widgets/id_badge.dart';

void main() {
  group('GPS List Item:', () {
    var gpsFootprint = GPSFootprint(1, 51.12345, 21.12345, DateTime(2020, 6, 1, 12, 34, 56), 0);
    var widgetsTree = MaterialApp(
      home: Scaffold(
        body: GPSListItem(gpsFootprint),
      ),
    );

    testWidgets('has title with coordinates', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.text('(51.123, 21.123)'), findsOneWidget);
    });

    testWidgets('has subtitle with formatted date time', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.text('2020-06-01 12:34:56'), findsOneWidget);
    });

    testWidgets('has location icon', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byIcon(Icons.my_location), findsOneWidget);
    });

    testWidgets('has ID badge', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byType(IDBadge), findsOneWidget);
    });
  });
}
