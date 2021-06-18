import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Credit Cards Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final creditCardCvcText = find.byValueKey("CreditCard_cvc_text");
    final creditCardExpirationDateText =
        find.byValueKey("CreditCard_expirationDate_text");
    final creditCardNumberText = find.byValueKey("CreditCard_number_text");
    final creditCardInsertButton = find.byValueKey("CreditCard_insert_button");
    final accountButton = find.byValueKey("Home_AccountButton");
    final creditCardButton = find.byValueKey("Account_CreditCard_Button");

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

    test('Enter in the credit card personal section', () async {
      await driver.tap(accountButton);
      await driver.tap(creditCardButton);
    });
    test('Cards CVC not inserted doesnt allow to add a new card', () async {
      await driver.tap(creditCardCvcText);
      await driver.enterText("");
      await driver.tap(creditCardExpirationDateText);
      await driver.enterText("12/11/2022");
      await driver.tap(creditCardNumberText);
      await driver.enterText("1111 0000 1111 0000");
      await driver.tap(creditCardInsertButton);
    });
    test('Expiration date not inserted doesnt allow to add a new card',
        () async {
      await driver.tap(creditCardCvcText);
      await driver.enterText("919");
      await driver.tap(creditCardExpirationDateText);
      await driver.enterText("");
      await driver.tap(creditCardNumberText);
      await driver.enterText("1111 0000 1111 0000");
      await driver.tap(creditCardInsertButton);
    });

    test('Cards number not inserted doesnt allow to add a new card', () async {
      await driver.tap(creditCardCvcText);
      await driver.enterText("919");
      await driver.tap(creditCardExpirationDateText);
      await driver.enterText("12/11/2022");
      await driver.tap(creditCardNumberText);
      await driver.enterText("");
      await driver.tap(creditCardInsertButton);
    });

    test('All data inserted correctly allow to add a new card', () async {
      await driver.tap(creditCardCvcText);
      await driver.enterText("919");
      await driver.tap(creditCardExpirationDateText);
      await driver.enterText("12/11/2022");
      await driver.tap(creditCardNumberText);
      await driver.enterText("1111 0000 1111 0000");
      await driver.tap(creditCardInsertButton);
    });
  });
}
