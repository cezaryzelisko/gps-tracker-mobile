import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/modal.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';

class SortModal extends StatelessWidget {
  final void Function(SortOptions option) sortOptionHandler;
  final SortOptions defaultOption;
  
  final _sortKey = GlobalKey<SortMenuState>();

  SortModal(this.sortOptionHandler, [this.defaultOption = SortOptions.newest]);

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
                SortMenu(_sortKey, 'Sort date:', defaultOption),
                RaisedButton(
                  child: Text('Apply sorting'),
                  onPressed: () {
                    sortOptionHandler(_sortKey.currentState.option);
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
