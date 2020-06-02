import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/gps_list_item.dart';

class ListWithFilters extends StatelessWidget {
  final List<GPSFootprint> items;

  ListWithFilters({this.items = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Filters'),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => GPSListItem(items[index]),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}
