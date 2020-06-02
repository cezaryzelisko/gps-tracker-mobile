import 'package:flutter/widgets.dart';
import 'package:gps_tracker_mobile/utils/http_tools.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:gps_tracker_mobile/models/user.dart';

class UserProvider with ChangeNotifier {
  User user;
  var error = '';

  UserProvider() {
    user = User.empty();
  }

  Future<void> login(String username, String password) async {
    var body = {
      'username': username,
      'password': password,
    };
    var response = await http.post(
      getUrl('auth', 'obtain_token'),
      body: convert.jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      user.fromMap(convert.jsonDecode(response.body));
      error = '';
    } else {
      error = 'Unable to log in';
    }
    notifyListeners();
  }
}
