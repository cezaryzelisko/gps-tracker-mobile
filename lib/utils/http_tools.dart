import 'package:gps_tracker_mobile/config.dart' show config;

String getUrl(section, option) {
  var sectionConfig = config['endpoints'][section] as Map<String, String>;
  return [config['endpoints']['root'], section, sectionConfig[option]].join('/');
}
