import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/modal.dart';

class SortMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Icon(Icons.sort),
      ),
      onTap: () async {
        await showModal(
          context,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sort date by:'),
                RaisedButton(
                  child: Text('Apply sorting'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
