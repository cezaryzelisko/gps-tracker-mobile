import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login functionalities:', () {
    // Connect to the Flutter driver before running any tests
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    // Run tests
    test('can log in', () async {
      // Prepare credentials
      final username = 'admin'; // replace with valid API user name
      final password = 'admin123'; // replace with valid API user password

      // Find necessary widgets
      final usernameField = find.byValueKey('username');
      final passwordField = find.byValueKey('password');
      final loginButton = find.byValueKey('login');
      final homeScreen = find.byValueKey('home_screen');

      // Focus username field and enter text
      await driver.tap(usernameField);
      await driver.enterText(username);

      // Focus [password] field and enter text
      await driver.tap(passwordField);
      await driver.enterText(password);

      // Click login button
      await driver.tap(loginButton);

      await driver.waitFor(homeScreen, timeout: Duration(seconds: 3));
    });
  });
}
