import 'package:flutter/material.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/utils/datetime_utils.dart';
import 'package:gps_tracker_mobile/widgets/id_badge.dart';

class GPSListItem extends StatelessWidget {
  final GPSFootprint gpsFootprint;

  GPSListItem(this.gpsFootprint);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('(${gpsFootprint.lat.toStringAsFixed(3)}, ${gpsFootprint.lng.toStringAsFixed(3)})'),
      subtitle: Text(formatDateTime(gpsFootprint.publishedAt)),
      leading: Icon(Icons.my_location),
      trailing: IDBadge(gpsFootprint.deviceID),
      onTap: () {
        print(gpsFootprint);
      },
    );
  }
}
