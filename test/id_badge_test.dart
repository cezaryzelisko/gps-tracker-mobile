import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/id_badge.dart';

void main() {
  testWidgets('ID Badge: has text with the given ID', (tester) async {
    var widgetsTree = Directionality(
      textDirection: TextDirection.ltr,
      child: IDBadge(1),
    );

    await tester.pumpWidget(widgetsTree);
    final idFinder = find.text('ID: 1');
    expect(idFinder, findsOneWidget);
  });
}
