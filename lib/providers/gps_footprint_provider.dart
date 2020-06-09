import 'dart:convert' as convert;
import 'package:flutter/widgets.dart';

import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/utils/http_tools.dart';

class GPSFootprintProvider with ChangeNotifier {
  List<GPSFootprint> gpsFootprints;

  GPSFootprintProvider() {
    gpsFootprints = [];
  }

  Future<void> downloadGPSFootprints(ApiClient apiClient, {notify = true}) async {
    var response = await apiClient.get(getUrl('api', 'gps_footprint'));
    var data = convert.jsonDecode(response.body);
    gpsFootprints.addAll(data.map<GPSFootprint>((gpsFootprint) => GPSFootprint.fromMap(gpsFootprint)).toList());
    if (notify) {
      notifyListeners();
    }
  }

  Future<List<GPSFootprint>> getGpsFootprints(ApiClient apiClient) async {
    if (gpsFootprints.length == 0) {
      await downloadGPSFootprints(apiClient);
    }

    return gpsFootprints;
  }
}
