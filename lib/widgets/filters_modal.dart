import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';
import 'package:gps_tracker_mobile/utils/data_manipulation.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';
import 'package:gps_tracker_mobile/widgets/modal.dart';
import 'package:gps_tracker_mobile/widgets/filters_menu.dart';

class FiltersModal extends StatelessWidget {
  final void Function(DateTime firstDate, DateTime lastDate, List<int> selectedIDs) filtersHandler;
  final DateTime defaultFirstDate;
  final DateTime defaultLastDate;
  final List<int> defaultSelectedIDs;

  final _firstDateKey = GlobalKey<FilterDateMenuState>();
  final _lastDateKey = GlobalKey<FilterDateMenuState>();
  final _idKey = GlobalKey<FilterCheckboxMenuState>();

  FiltersModal(this.filtersHandler, [this.defaultFirstDate, this.defaultLastDate, this.defaultSelectedIDs]);

  List<DateTime> findBoundaries(BuildContext context) {
    var gpsFootprints = context.watch<GPSFootprintProvider>().gpsFootprints;
    gpsFootprints = sortGPSFootprints(gpsFootprints, SortOptions.oldest);

    return [gpsFootprints[0].publishedAt, gpsFootprints[gpsFootprints.length - 1].publishedAt];
  }

  @override
  Widget build(BuildContext context) {
    var dateBoundaries = findBoundaries(context);

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
        DateTime firstDate, lastDate;
        List<int> selectedIDs;
        await showModal(
          context,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Filter date:'),
                FilterDateMenu(
                  _firstDateKey,
                  'From',
                  'begining',
                  defaultFirstDate,
                  dateBoundaries[0],
                  dateBoundaries[1],
                ),
                FilterDateMenu(
                  _lastDateKey,
                  'To',
                  'end',
                  defaultLastDate,
                  dateBoundaries[0],
                  dateBoundaries[1],
                ),
                Text('Filter device ID:'),
                FilterCheckboxMenu(_idKey, defaultSelectedIDs),
                RaisedButton(
                  child: Text('Apply filters'),
                  onPressed: () {
                    firstDate = _firstDateKey.currentState.date;
                    lastDate = _lastDateKey.currentState.date;
                    selectedIDs = _idKey.currentState.checked;

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
        filtersHandler(firstDate, lastDate, selectedIDs);
      },
    );
  }
}
