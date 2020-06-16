import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gps_tracker_mobile/widgets/gps_bubble.dart';
import 'package:gps_tracker_mobile/widgets/id_badge.dart';

void main() {
  group('GPS Bubble:', () {
      var widgetsTree = Directionality(
        textDirection: TextDirection.ltr,
        child: GPSBubble(1, DateTime(2020, 6, 1, 12, 34, 56), null),
      );
    testWidgets('has ID Badge', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byType(IDBadge), findsOneWidget);
    });

    testWidgets('has properly formatted date', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.text('2020-06-01 12:34:56'), findsOneWidget);
    });

    testWidgets('has close icon', (tester) async {
      await tester.pumpWidget(widgetsTree);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
