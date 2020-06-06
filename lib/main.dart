import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';
import 'package:gps_tracker_mobile/providers/user_provider.dart';
import 'package:gps_tracker_mobile/screens/login_screen.dart';
import 'package:gps_tracker_mobile/screens/home_screen.dart';
import 'package:gps_tracker_mobile/screens/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => GPSFootprintProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) => MaterialApp(
          title: 'GPS Tracker',
          theme: _theme,
          home: userProvider.user.isLoggedIn() ? HomeScreen() : LoginScreen(),
          routes: {
            MapScreen.ROUTE_NAME: (ctx) => MapScreen(),
          },
        ),
      ),
    );
  }
}

var _theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.blue,
  primaryColorBrightness: Brightness.dark,
  brightness: Brightness.dark,
  accentColor: Colors.lightBlue,
  toggleableActiveColor: Colors.blue,
  iconTheme: IconThemeData(color: Colors.lightBlueAccent),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  ),
);
