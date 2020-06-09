import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';

class GPSListItem extends StatelessWidget {
  final GPSFootprint gpsFootprint;

  GPSListItem(this.gpsFootprint);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('(${gpsFootprint.lat.toStringAsFixed(3)}, ${gpsFootprint.lng.toStringAsFixed(3)})'),
      subtitle: Text(gpsFootprint.publishedAt?.toLocal().toString()),
      leading: Icon(Icons.my_location),
      trailing: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Theme.of(context).accentColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text('ID: ${gpsFootprint.deviceID}'),
      ),
      onTap: () {
        print(gpsFootprint);
      },
    );
  }
}
