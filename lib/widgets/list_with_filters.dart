import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/filters_modal.dart';
import 'package:gps_tracker_mobile/widgets/gps_list_item.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';
import 'package:gps_tracker_mobile/widgets/sort_modal.dart';

class ListWithFilters extends StatefulWidget {
  final List<GPSFootprint> items;

  ListWithFilters({this.items = const []});

  @override
  _ListWithFiltersState createState() => _ListWithFiltersState();
}

class _ListWithFiltersState extends State<ListWithFilters> {
  DateTime _firstDate;
  DateTime _lastDate;
  SortOptions _sortOption = SortOptions.newest;

  void setDateFrame(DateTime firstDate, DateTime lastDate) {
    setState(() {
      _firstDate = firstDate;
      _lastDate = lastDate;
    });
  }

  void setSortOption(SortOptions option) {
    setState(() {
      _sortOption = option;
    });
  }

  int fromNewestComparator(GPSFootprint footprint1, GPSFootprint footprint2) {
    return footprint2.publishedAt.millisecondsSinceEpoch - footprint1.publishedAt.millisecondsSinceEpoch;
  }

  int fromOldestComparator(GPSFootprint footprint1, GPSFootprint footprint2) {
    return footprint1.publishedAt.millisecondsSinceEpoch - footprint2.publishedAt.millisecondsSinceEpoch;
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
    }).toList()
      ..sort(_sortOption == SortOptions.newest ? fromNewestComparator : fromOldestComparator);
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
              FiltersModal(setDateFrame, _firstDate, _lastDate),
              SortModal(setSortOption, _sortOption),
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
