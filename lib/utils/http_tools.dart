import 'package:http/http.dart';

import 'package:gps_tracker_mobile/models/user.dart';
import 'package:gps_tracker_mobile/config.dart' show config;

String getUrl(section, option) {
  var sectionConfig = config['endpoints'][section] as Map<String, String>;
  return [config['endpoints']['root'], section, sectionConfig[option]].join('/');
}

class ApiClient extends BaseClient {
  final User _user;
  Client _client;

  ApiClient(this._user) {
    _client = Client();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (!_user.isLoggedIn()) {
      throw NotAuthorizedException;
    }

    request.headers['Authorization'] = 'Bearer ${_user.accessToken}';

    return _client.send(request);
  }
}

class NotAuthorizedException implements Exception {
  String get message => 'You are not authorized. Please check your credentials validity';
}
