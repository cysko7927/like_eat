// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('SignUp Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final signUpNameText = find.byValueKey("sign_up_name_text");
    final signUpSurnameText = find.byValueKey("sign_up_surname_text");
    final signUpNicknameText = find.byValueKey("sign_up_nickname_text");
    final signUpEmailTextForm = find.byValueKey("sign_up_email_textForm");
    final signUpPassword1TextForm =
        find.byValueKey("sign_up_password1_textForm");
    final signUpPassword2TextForm =
        find.byValueKey("sign_up_password2_textForm");
    final signUpRegisterButton = find.byValueKey("sign_up_register_button");
    final signUpCheckBox = find.byValueKey("sign_up_checkbox");

    final emailVerificationBack = find.byValueKey("emailVerification_back");
    final enterSignUp = find.byValueKey("sign_in_enterSignUp_button");
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
    test('Enter in the Sign Up', () async {
      await driver.tap(enterSignUp);
    });
    test('Wrong email format doesnt allow to proced', () async {
      // First, tap on the button
      await driver.tap(signUpNameText);
      await driver.enterText("Matteo");
      await driver.tap(signUpSurnameText);
      await driver.enterText("Cecini");
      await driver.tap(signUpNicknameText);
      await driver.enterText("Cesna");
      await driver.tap(signUpEmailTextForm);
      await driver.enterText("Matteociao.it");
      await driver.tap(signUpPassword1TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpPassword2TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpCheckBox);
      await driver.tap(signUpRegisterButton);
    });
    test('Confirm password different from the first one doesnt allow to proced',
        () async {
      await driver.tap(signUpNameText);
      await driver.enterText("Matteo");
      await driver.tap(signUpSurnameText);
      await driver.enterText("Cecini");
      await driver.tap(signUpNicknameText);
      await driver.enterText("Cesna");
      await driver.tap(signUpEmailTextForm);
      await driver.enterText("Matteo@ciao.it");
      await driver.tap(signUpPassword1TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpPassword2TextForm);
      await driver.enterText("Cecini123");
      await driver.tap(signUpCheckBox);
      await driver.tap(signUpRegisterButton);
    });
    test(
        'All data correct but not accepted the privacy policy doesnt allow to proced',
        () async {
      // First, tap on the button
      await driver.tap(signUpNameText);
      await driver.enterText("Matteo");
      await driver.tap(signUpSurnameText);
      await driver.enterText("Cecini");
      await driver.tap(signUpNicknameText);
      await driver.enterText("Cesna");
      await driver.tap(signUpEmailTextForm);
      await driver.enterText("Matteo@ciao.it");
      await driver.tap(signUpPassword1TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpPassword2TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpRegisterButton);
    });
    test('All data correct allow to proced', () async {
      await driver.tap(signUpNameText);
      await driver.enterText("Matteo");
      await driver.tap(signUpSurnameText);
      await driver.enterText("Cecini");
      await driver.tap(signUpNicknameText);
      await driver.enterText("Cesna");
      await driver.tap(signUpEmailTextForm);
      await driver.enterText("Matteo@help.it");
      await driver.tap(signUpPassword1TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpPassword2TextForm);
      await driver.enterText("Cecini124");
      await driver.tap(signUpCheckBox);
      await driver.tap(signUpRegisterButton);
      await driver.tap(emailVerificationBack);
    });
  });
}
