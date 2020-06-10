import 'dart:convert' as convert;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:gps_tracker_mobile/utils/http_tools.dart';
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
    try {
      var response = await http.post(
        getUrl('auth', 'obtain_token'),
        body: convert.jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // OK
        user.fromMap(convert.jsonDecode(response.body));
        error = '';
      } else if (response.statusCode == 401) {
        // unauthorized
        error = 'Invalid username and/or password.';
      } else {
        error = 'Unable to log in';
      }
    } catch (exception) {
      error = 'Error occurred while connecting to the server.';
    } finally {
      notifyListeners();
    }
  }

  void logout() {
    user = User.empty();
    notifyListeners();
  }
}
