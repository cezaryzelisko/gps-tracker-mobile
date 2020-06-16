import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';

import 'package:gps_tracker_mobile/widgets/filters_menu.dart';
import 'package:provider/provider.dart';

void main() {
  group('Filter Date Menu:', () {
    var groupLabel = 'date filtering';
    var fixedLabel = 'start';
    var initialDate = DateTime(2020, 6, 14);
    var filterMenuKey = GlobalKey<FilterDateMenuState>();
    var widgetsTree = MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: FilterDateMenu(
            filterMenuKey,
            groupLabel,
            fixedLabel,
            initialDate,
            DateTime(2020, 6, 1),
            DateTime(2020, 6, 30),
          ),
        ),
      ),
    );

    testWidgets('has group label', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.text('date filtering'), findsOneWidget);
    });

    testWidgets('has 2 options', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.widgetWithText(ListTile, fixedLabel), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'custom date:'), findsOneWidget);
    });

    testWidgets('sets default date', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(filterMenuKey.currentState.date, initialDate);
    });
  });

  group('Filter Checkbox Menu:', () {
    var gpsFootprints = [
      GPSFootprint(null, null, null, null, 1),
      GPSFootprint(null, null, null, null, 2),
      GPSFootprint(null, null, null, null, 3),
      GPSFootprint(null, null, null, null, 4),
      GPSFootprint(null, null, null, null, 5),
    ];
    var checkedIDs = [1, 4, 5];
    var filterMenuKey = GlobalKey<FilterCheckboxMenuState>();
    var widgetsTree = MaterialApp(
      home: ChangeNotifierProvider(
        create: (ctx) => GPSFootprintProvider(gpsFootprints),
        child: Scaffold(
          body: SingleChildScrollView(
            child: FilterCheckboxMenu(
              filterMenuKey,
              checkedIDs.sublist(0),
            ),
          ),
        ),
      ),
    );

    testWidgets('has ${gpsFootprints.length} options', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byType(CheckboxListTile), findsNWidgets(gpsFootprints.length));
      for (var gpsF in gpsFootprints) {
        expect(find.widgetWithText(CheckboxListTile, 'Device ID: ${gpsF.deviceID}'), findsOneWidget);
      }
    });

    testWidgets('sets default checks', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(filterMenuKey.currentState.checked, checkedIDs);
    });

    testWidgets('can handle changes', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(filterMenuKey.currentState.checked, checkedIDs);
      await tester.tap(find.widgetWithText(CheckboxListTile, 'Device ID: 2'));
      await tester.pump();
      expect(filterMenuKey.currentState.checked, checkedIDs + [2]);
    });
  });
}
