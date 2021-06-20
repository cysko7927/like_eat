// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('SignIn Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final signInEmailText = find.byValueKey("sign_in_email_text");
    final signInPasswordText = find.byValueKey("sign_in_password_text");
    final signInLoginButton = find.byValueKey("sign_in_login_button");
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Try to log in without putting an email', () async {
      // First, tap on the button
      await driver.tap(signInEmailText);
      await driver.enterText("");
      await driver.tap(signInPasswordText);
      await driver.enterText("matteo124");
      await driver.tap(signInLoginButton);
    });
    test('Try to log in without putting a password', () async {
      // First, tap on the button
      await driver.tap(signInEmailText);
      await driver.enterText("matteo.cecini.95@gmail.com");
      await driver.tap(signInPasswordText);
      await driver.enterText("");
      await driver.tap(signInLoginButton);
    });
    test('Try to log in with an unexisting email', () async {
      // First, tap on the button
      await driver.tap(signInEmailText);
      await driver.enterText("matteo.cecini@hello.com");
      await driver.tap(signInPasswordText);
      await driver.enterText("matteo124");
      await driver.tap(signInLoginButton);
    });
    test('Try to log in with a wrong password', () async {
      // First, tap on the button
      await driver.tap(signInEmailText);
      await driver.enterText("matteo.cecini.95@gmail.com");
      await driver.tap(signInPasswordText);
      await driver.enterText("matteo123");
      await driver.tap(signInLoginButton);
    });
    test('Try to log in with all correct data', () async {
      // First, tap on the button
      await driver.tap(signInEmailText);
      await driver.enterText("matteo.cecini.95@gmail.com");
      await driver.tap(signInPasswordText);
      await driver.enterText("matteo124");
      await driver.tap(signInLoginButton);
    });
  });
}
