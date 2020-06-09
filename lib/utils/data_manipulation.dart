import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';

var sorter = {
  SortOptions.newest: (GPSFootprint footprint1, GPSFootprint footprint2) =>
      footprint2.publishedAt.millisecondsSinceEpoch - footprint1.publishedAt.millisecondsSinceEpoch,
  SortOptions.oldest: (GPSFootprint footprint1, GPSFootprint footprint2) =>
      footprint1.publishedAt.millisecondsSinceEpoch - footprint2.publishedAt.millisecondsSinceEpoch,
  SortOptions.device_id_az: (GPSFootprint footprint1, GPSFootprint footprint2) =>
      footprint1.deviceID - footprint2.deviceID,
  SortOptions.device_id_za: (GPSFootprint footprint1, GPSFootprint footprint2) =>
      footprint2.deviceID - footprint1.deviceID,
};

List<GPSFootprint> sortGPSFootprints(List<GPSFootprint> items, SortOptions option) => items..sort(sorter[option]);

List<GPSFootprint> filterGPSFootprints(
  List<GPSFootprint> items,
  DateTime firstDate,
  DateTime lastDate,
  List<int> selectedIDs,
) {
  return items.where((gpsFootprint) {
    if (firstDate != null && gpsFootprint.publishedAt.isBefore(firstDate)) {
      return false;
    }

    if (lastDate != null && gpsFootprint.publishedAt.isAfter(lastDate)) {
      return false;
    }

    if (selectedIDs != null && selectedIDs.indexOf(gpsFootprint.deviceID) == -1) {
      return false;
    }

    return true;
  }).toList();
}
