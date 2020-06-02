import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/widgets/gps_map.dart';
import 'package:gps_tracker_mobile/widgets/list_with_filters.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE_NAME = '/home';

  Future<void> refreshHandler() async {
    print('refreshed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GPSMap(),
            Expanded(
              child: ListWithFilters(),
            ),
          ],
        ),
        onRefresh: refreshHandler,
      ),
    );
  }
}
