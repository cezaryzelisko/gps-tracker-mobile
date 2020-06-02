import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/providers/user_provider.dart';
import 'package:gps_tracker_mobile/screens/home_screen.dart';

import 'package:gps_tracker_mobile/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) => MaterialApp(
          title: 'GPS Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: userProvider.user.isLoggedIn() ? HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
