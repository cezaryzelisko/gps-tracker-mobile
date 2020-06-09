import 'package:gps_tracker_mobile/models/gps_footprint.dart';
import 'package:gps_tracker_mobile/widgets/sort_menu.dart';

int fromNewestComparator(GPSFootprint footprint1, GPSFootprint footprint2) {
  return footprint2.publishedAt.millisecondsSinceEpoch - footprint1.publishedAt.millisecondsSinceEpoch;
}

int fromOldestComparator(GPSFootprint footprint1, GPSFootprint footprint2) {
  return footprint1.publishedAt.millisecondsSinceEpoch - footprint2.publishedAt.millisecondsSinceEpoch;
}

List<GPSFootprint> sortGPSFootprints(List<GPSFootprint> items, SortOptions option) {
  return items..sort(option == SortOptions.newest ? fromNewestComparator : fromOldestComparator);
}

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
