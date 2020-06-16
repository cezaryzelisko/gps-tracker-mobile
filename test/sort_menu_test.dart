import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';

void main() {
  group('Sort Menu:', () {
    var label = 'sorting';
    var sortMenuKey = GlobalKey<SortMenuState>();
    var widgetsTree = MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SortMenu(
            sortMenuKey,
            label,
          ),
        ),
      ),
    );

    testWidgets('has label', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('has 4 options', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byType(ListTile), findsNWidgets(4));
      expect(find.widgetWithText(ListTile, 'from newest'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'from oldest'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'device ID A->Z'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'device ID Z->A'), findsOneWidget);
    });

    testWidgets('can handle option changes', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(sortMenuKey.currentState.option, SortOptions.newest);
      await tester.tap(find.widgetWithText(ListTile, 'from oldest'));
      await tester.pump();
      expect(sortMenuKey.currentState.option, SortOptions.oldest);
    });
  });
}
