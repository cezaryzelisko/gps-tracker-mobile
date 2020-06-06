import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/widgets/gps_map.dart';
import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';

class MapScreen extends StatelessWidget {
  static const ROUTE_NAME = '/map';

  @override
  Widget build(BuildContext context) {
    var gpsFootprints = context.watch<GPSFootprintProvider>().gpsFootprints;

    return Scaffold(
      body: Stack(
        children: [
          GPSMap(
            initialCoords: gpsFootprints.length > 0 ? gpsFootprints[0] : null,
            markersCoords: gpsFootprints,
          ),
          Positioned(
            top: 32,
            left: 8,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
