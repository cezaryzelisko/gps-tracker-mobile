import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/filters_modal.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';
import 'package:gps_tracker_mobile/widgets/sort_modal.dart';

class FilterSort extends StatelessWidget {
  final String title;
  final void Function(DateTime firstDate, DateTime lastDate, List<int> selectedIDs) onFiltersUpdated;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<int> selectedIDs;
  final void Function(SortOptions option) onSortOptionUpdated;
  final SortOptions sortOption;

  FilterSort({
    this.title = '',
    this.onFiltersUpdated,
    this.firstDate,
    this.lastDate,
    this.selectedIDs,
    this.onSortOptionUpdated,
    this.sortOption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 4, top: 4, right: 4),
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FiltersModal(onFiltersUpdated, firstDate, lastDate, selectedIDs),
          Text(title),
          SortModal(onSortOptionUpdated, sortOption),
        ],
      ),
    );
  }
}
