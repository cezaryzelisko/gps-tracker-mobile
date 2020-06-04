import 'package:flutter/material.dart';

class GPSBubble extends StatelessWidget {
  final DateTime date;
  final void Function() closeBubble;

  GPSBubble(this.date, this.closeBubble);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${date.toLocal().toString()}'),
            SizedBox(width: 16),
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
