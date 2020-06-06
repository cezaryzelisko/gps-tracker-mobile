import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/modal.dart';
import 'package:gps_tracker_mobile/widgets/filters_menu.dart';

class FiltersModal extends StatelessWidget {
  final void Function(DateTime firstDate, DateTime lastDate) dateHandler;
  final DateTime defaultFirstDate;
  final DateTime defaultLastDate;

  final _firstDateKey = GlobalKey<FiltersMenuState>();
  final _lastDateKey = GlobalKey<FiltersMenuState>();
  DateTime _firstDate;
  DateTime _lastDate;

  FiltersModal(this.dateHandler, [this.defaultFirstDate, this.defaultLastDate]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Icon(
          Icons.filter_list,
          semanticLabel: 'Filtering',
        ),
      ),
      onTap: () async {
        await showModal(
          context,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Filter date:'),
                FiltersMenu(_firstDateKey, 'From', 'begining', defaultFirstDate),
                FiltersMenu(_lastDateKey, 'To', 'end', defaultLastDate),
                RaisedButton(
                  child: Text('Apply filters'),
                  onPressed: () {
                    _firstDate = _firstDateKey.currentState.date;
                    _lastDate = _lastDateKey.currentState.date;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
        dateHandler(_firstDate, _lastDate);
      },
    );
  }
}
