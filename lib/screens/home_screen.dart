import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/utils/data_manipulation.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/widgets/filter_sort.dart';
import 'package:gps_tracker_mobile/widgets/gps_list_item.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';
import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';
import 'package:gps_tracker_mobile/providers/user_provider.dart';
import 'package:gps_tracker_mobile/screens/map_screen.dart';
import 'package:gps_tracker_mobile/widgets/gps_map.dart';
import 'package:gps_tracker_mobile/utils/http_tools.dart';

enum HomeMenuItems {
  refresh,
  logout,
}

class HomeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiClient _apiClient;
  List<GPSFootprint> gpsFootprints = [];
  DateTime _firstDate;
  DateTime _lastDate;
  SortOptions _sortOption = SortOptions.newest;
  List<int> _selectedIDs;

  void initState() {
    super.initState();
    var user = context.read<UserProvider>().user;
    _apiClient = ApiClient(user);
    context.read<GPSFootprintProvider>().downloadGPSFootprints(_apiClient);
  }

  Future<void> refreshHandler() async {
    context.read<GPSFootprintProvider>().downloadGPSFootprints(_apiClient);
  }

  void menuItemHandler(HomeMenuItems item) {
    switch (item) {
      case HomeMenuItems.refresh:
        refreshHandler();
        break;
      case HomeMenuItems.logout:
        context.read<UserProvider>().logout();
        break;
    }
  }

  void filtersHandler(DateTime firstDate, DateTime lastDate, List<int> selectedIDs) {
    setState(() {
      _firstDate = firstDate;
      _lastDate = lastDate;
      _selectedIDs = selectedIDs;
    });
  }

  void sortOptionHandler(SortOptions option) {
    setState(() {
      _sortOption = option;
    });
  }

  void updateGPSFootprints(List<GPSFootprint> data) {
    gpsFootprints.clear();
    setState(() {
      gpsFootprints.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    var gpsFootprintProvider = context.watch<GPSFootprintProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Tracker'),
        centerTitle: true,
        actions: [
          PopupMenuButton<HomeMenuItems>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: HomeMenuItems.refresh,
                child: Text('Refresh'),
              ),
              PopupMenuItem(
                value: HomeMenuItems.logout,
                child: Text('Logout'),
              ),
            ],
            onSelected: menuItemHandler,
          ),
        ],
      ),
      body: FutureBuilder<List<GPSFootprint>>(
        future: gpsFootprintProvider.getGPSFootprints(_apiClient),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Widget body;
            if (snapshot.data != null) {
              gpsFootprints = filterGPSFootprints(
                snapshot.data,
                firstDate: _firstDate,
                lastDate: _lastDate,
                selectedIDs: _selectedIDs,
              );
              gpsFootprints = sortGPSFootprints(gpsFootprints, _sortOption);
              body = Column(
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
                        top: 0,
                        right: 12,
                        child: IconButton(
                          icon: Icon(Icons.fullscreen, size: 48),
                          onPressed: () => Navigator.of(context).pushNamed(MapScreen.ROUTE_NAME),
                        ),
                      ),
                    ]),
                  ),
                  FilterSort(
                    title: 'GPS Footprints',
                    onFiltersUpdated: filtersHandler,
                    firstDate: _firstDate,
                    lastDate: _lastDate,
                    selectedIDs: _selectedIDs,
                    onSortOptionUpdated: sortOptionHandler,
                    sortOption: _sortOption,
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GPSListItem(gpsFootprints[index]),
                      itemCount: gpsFootprints.length,
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
