import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/utils/datetime_utils.dart';
import 'package:gps_tracker_mobile/widgets/id_badge.dart';

class GPSBubble extends StatelessWidget {
  final int id;
  final DateTime date;
  final void Function() closeBubble;

  GPSBubble(this.id, this.date, this.closeBubble);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IDBadge(id),
            SizedBox(width: 4),
            Text(formatDateTime(date)),
            SizedBox(width: 8),
            InkWell(
              child: Icon(Icons.close),
              onTap: closeBubble,
            ),
          ],
        ),
      ),
    );
  }
}
