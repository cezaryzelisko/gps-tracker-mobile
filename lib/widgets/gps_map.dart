import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';

class GPSMap extends StatelessWidget {
  LatLng _initialCoords;
  List<Marker> _markers;

  GPSMap({GPSFootprint initialCoords, List<GPSFootprint> markersCoords = const []}) {
    _initialCoords = initialCoords == null ? LatLng(0, 0) : LatLng(initialCoords.lat, initialCoords.lng);
    _markers = markersCoords.map((coords) => getMarker(coords)).toList();
  }

  Marker getMarker(GPSFootprint coords, {double size = 35}) {
    return Marker(
      width: size,
      height: size,
      point: LatLng(coords.lat, coords.lng),
      builder: (ctx) => GestureDetector(
        child: Icon(
          Icons.location_on,
          size: size,
        ),
        onTap: () {
          print('(${coords.lat.toStringAsFixed(3)}, ${coords.lng.toStringAsFixed(3)})');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.lightGreen,
      child: FlutterMap(
        options: MapOptions(
          center: _initialCoords,
          zoom: 13,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: _markers),
        ],
      ),
    );
  }
}
