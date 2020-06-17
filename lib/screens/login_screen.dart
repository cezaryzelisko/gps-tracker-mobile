import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _password = '';
  var _loginEnabled = false;
  var _passwordFocus = FocusNode();

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
              child: Text(
                userProvider.error,
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Form(
              key: _formKey,
              autovalidate: true,
              onChanged: () {
                setState(() {
                  _loginEnabled = _formKey.currentState.validate();
                });
              },
              child: Column(
                children: [
                  TextFormField(
                    key: Key('username'),
                    decoration: InputDecoration(labelText: 'username'),
                    validator: (value) {
                      if (value.length >= 3 || value.length == 0) {
                        return null;
                      } else {
                        return 'Wrong username';
                      }
                    },
                    initialValue: _username,
                    onSaved: (newValue) => _username = newValue,
                    autofocus: true,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) => _passwordFocus.requestFocus(),
                  ),
                  TextFormField(
                    key: Key('password'),
                    focusNode: _passwordFocus,
                    decoration: InputDecoration(labelText: 'password'),
                    validator: (value) {
                      if (value.length >= 6 || value.length == 0) {
                        return null;
                      } else {
                        return 'Wrong password';
                      }
                    },
                    initialValue: _password,
                    onSaved: (newValue) => _password = newValue,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 8),
                  RaisedButton(
                    key: Key('login'),
                    child: Text('Log in'),
                    onPressed: _loginEnabled ? () => loginHandler(userProvider) : null,
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
