import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/filters.dart';
import 'package:gps_tracker_mobile/widgets/gps_list_item.dart';

class ListWithFilters extends StatefulWidget {
  final List<GPSFootprint> items;

  ListWithFilters({this.items = const []});

  @override
  _ListWithFiltersState createState() => _ListWithFiltersState();
}

class _ListWithFiltersState extends State<ListWithFilters> {
  DateTime _firstDate;
  DateTime _lastDate;

  void setDateFrame(DateTime firstDate, DateTime lastDate) {
    setState(() {
      _firstDate = firstDate;
      _lastDate = lastDate;
    });
  }

  List<GPSFootprint> filterFootprints() {
    return widget.items.where((footprint) {
      if (_firstDate != null && footprint.publishedAt.isBefore(_firstDate)) {
        return false;
      }

      if (_lastDate != null && footprint.publishedAt.isAfter(_lastDate)) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var footprints = filterFootprints();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          margin: const EdgeInsets.only(left: 4, top: 4, right: 4),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Filters(setDateFrame),
              Text('sort'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => GPSListItem(footprints[index]),
            itemCount: footprints.length,
          ),
        ),
      ],
    );
  }
}
