import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _password = '';

  void loginHandler(UserProvider provider) {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      provider.login(_username, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 150,
          ),
          if (userProvider.error.length > 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(userProvider.error),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'username'),
                    validator: (value) {
                      if (value.length >= 3) {
                        return null;
                      } else {
                        return 'Wrong username';
                      }
                    },
                    initialValue: _username,
                    onSaved: (newValue) => _username = newValue,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'password'),
                    validator: (value) {
                      if (value.length >= 6) {
                        return null;
                      } else {
                        return 'Wrong password';
                      }
                    },
                    initialValue: _password,
                    onSaved: (newValue) => _password = newValue,
                    obscureText: true,
                  ),
                  RaisedButton(
                    child: Text('Log in'),
                    onPressed: () => loginHandler(userProvider),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
