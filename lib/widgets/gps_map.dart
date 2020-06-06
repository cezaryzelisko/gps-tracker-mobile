import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/map/flutter_map_state.dart';
import 'package:latlong/latlong.dart';

import 'package:gps_tracker_mobile/widgets/gps_bubble.dart';
import 'package:gps_tracker_mobile/models/gps_footprint.dart';

class GPSMap extends StatefulWidget {
  LatLng _initialCoords;
  List<GPSFootprint> markersCoords;

  GPSMap({GPSFootprint initialCoords, this.markersCoords = const []}) {
    _initialCoords = initialCoords == null ? LatLng(0, 0) : LatLng(initialCoords.lat, initialCoords.lng);
  }

  @override
  _GPSMapState createState() => _GPSMapState();
}

class _GPSMapState extends State<GPSMap> {
  final _mapState = GlobalKey<FlutterMapState>();
  GPSBubble _bubble;
  int _markerIndex;

  Marker getMarker(int index, GPSFootprint footprint, {double size = 35}) {
    return Marker(
      width: size,
      height: size,
      point: LatLng(footprint.lat, footprint.lng),
      builder: (ctx) => GestureDetector(
        child: Icon(
          Icons.location_on,
          size: size,
        ),
        onTap: () => bubbleHandler(
          index,
          GPSBubble(
            footprint.publishedAt,
            () => bubbleHandler(-1, null),
          ),
        ),
      ),
    );
  }

  Widget getPositionedMarker(Marker marker) {
    var map = _mapState.currentState.mapState;
    var pos = map.project(marker.point);
    pos = pos.multiplyBy(map.getZoomScale(map.zoom, map.zoom)) - map.getPixelOrigin();

    var pixelPosX = (pos.x - (marker.width - marker.anchor.left)).toDouble();
    var pixelPosY = (pos.y - (marker.height - marker.anchor.top)).toDouble();

    return Positioned(
      top: pixelPosY,
      left: pixelPosX,
      child: _bubble,
    );
  }

  void bubbleHandler(int index, GPSBubble bubble) {
    setState(() {
      _bubble = bubble;
      _markerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = List(widget.markersCoords.length);
    for (var i = 0; i < markers.length; i++) {
      markers[i] = getMarker(i, widget.markersCoords[i]);
    }

    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          FlutterMap(
            key: _mapState,
            options: MapOptions(
              center: widget._initialCoords,
              zoom: widget._initialCoords.latitude == 0 && widget._initialCoords.longitude == 0 ? 1 : 13,
              onTap: (point) {
                setState(() {
                  _bubble = null;
                  _markerIndex = -1;
                });
              },
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: markers),
            ],
          ),
          if (_bubble != null) getPositionedMarker(markers[_markerIndex])
        ],
      ),
    );
  }
}
