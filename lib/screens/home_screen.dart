import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';
import 'package:gps_tracker_mobile/providers/user_provider.dart';
import 'package:gps_tracker_mobile/screens/map_screen.dart';
import 'package:gps_tracker_mobile/widgets/list_with_filters.dart';
import 'package:gps_tracker_mobile/widgets/gps_map.dart';
import 'package:gps_tracker_mobile/utils/http_tools.dart';

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiClient _apiClient;

  void initState() {
    super.initState();
    var user = context.read<UserProvider>().user;
    _apiClient = ApiClient(user);
    context.read<GPSFootprintProvider>().downloadGPSFootprints(_apiClient);
  }

  Future<void> refreshHandler() async {
    context.read<GPSFootprintProvider>().downloadGPSFootprints(_apiClient);
  }

  @override
  Widget build(BuildContext context) {
    var gpsFootprints = context.watch<GPSFootprintProvider>().gpsFootprints;

    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Stack(children: [
                GPSMap(
                  initialCoords: gpsFootprints.length > 0 ? gpsFootprints[0] : null,
                  markersCoords: gpsFootprints,
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: InkWell(
                    child: Icon(Icons.fullscreen, size: 48),
                    onTap: () => Navigator.of(context).pushNamed(MapScreen.ROUTE_NAME),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 3,
              child: ListWithFilters(
                items: gpsFootprints,
                title: 'GPS footprints',
              ),
            ),
          ],
        ),
        onRefresh: refreshHandler,
      ),
    );
  }
}
