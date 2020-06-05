import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/modal.dart';
import 'package:gps_tracker_mobile/widgets/radio_menu.dart';

class Filters extends StatefulWidget {
  final void Function(DateTime firstDate, DateTime lastDate) dateHandler;

  Filters(this.dateHandler);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _firstDateState = GlobalKey<RadioMenuState>();
  var _lastDateState = GlobalKey<RadioMenuState>();
  DateTime _firstDate;
  DateTime _lastDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Icon(Icons.filter_list),
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
                RadioMenu(_firstDateState, 'From', 'begining', DateTime.now()),
                RadioMenu(_lastDateState, 'To', 'end', DateTime.now()),
                RaisedButton(
                  child: Text('Apply filters'),
                  onPressed: () {
                    _firstDate = _firstDateState.currentState.date;
                    _lastDate = _lastDateState.currentState.date;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
        widget.dateHandler(_firstDate, _lastDate);
      },
    );
  }
}
