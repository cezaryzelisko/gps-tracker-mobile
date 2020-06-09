import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
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
    var gpsFootprintProvider = context.watch<GPSFootprintProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Tracker'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<GPSFootprint>>(
        future: gpsFootprintProvider.getGpsFootprints(_apiClient),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Widget body;
            if (snapshot.data != null) {
              body = Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(children: [
                      GPSMap(
                        initialCoords: snapshot.data.length > 0 ? snapshot.data[0] : null,
                        markersCoords: snapshot.data,
                      ),
                      Positioned(
                        top: 0,
                        right: 12,
                        child: IconButton(
                          icon: Icon(Icons.fullscreen, size: 48),
                          onPressed: () => Navigator.of(context).pushNamed(MapScreen.ROUTE_NAME),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListWithFilters(
                      items: snapshot.data,
                      title: 'GPS footprints',
                    ),
                  ),
                ],
              );
            } else {
              body = Center(
                child: Text('An error occurred while downloading data. Please try to refresh'),
              );
            }

            return RefreshIndicator(
              child: body,
              onRefresh: refreshHandler,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
