import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Shipping Address Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final stateText = find.byValueKey("SA_state_text");
    final addressText = find.byValueKey("SA_address_text");
    final cityText = find.byValueKey("SA_city_text");
    final capText = find.byValueKey("SA_CAP_text");
    final numberText = find.byValueKey("SA_number_text");
    final insertButton = find.byValueKey("SA_insert_button");
    final accountButton = find.byValueKey("Home_AccountButton");
    final shippingAddressButton =
        find.byValueKey("Account_ShippingAddress_Button");

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
    test('Enter in the shipping address personal section', () async {
      await driver.tap(accountButton);
      await driver.tap(shippingAddressButton);
    });
    test('State not inserted doesnt allow to add a new shipping address',
        () async {
      await driver.tap(stateText);
      await driver.enterText("");
      await driver.tap(addressText);
      await driver.enterText("Via Borch");
      await driver.tap(cityText);
      await driver.enterText("Livigno");
      await driver.tap(capText);
      await driver.enterText("23041");
      await driver.tap(numberText);
      await driver.enterText("34 a");
      await driver.tap(insertButton);
    });
    test('Address not inserted doesnt allow to add a new shipping address',
        () async {
      await driver.tap(stateText);
      await driver.enterText("Italia");
      await driver.tap(addressText);
      await driver.enterText("");
      await driver.tap(cityText);
      await driver.enterText("Livigno");
      await driver.tap(capText);
      await driver.enterText("23041");
      await driver.tap(numberText);
      await driver.enterText("34 a");
      await driver.tap(insertButton);
    });
    test('City not inserted doesnt allow to add a new shipping address',
        () async {
      await driver.tap(stateText);
      await driver.enterText("Italia");
      await driver.tap(addressText);
      await driver.enterText("Via Borch");
      await driver.tap(cityText);
      await driver.enterText("");
      await driver.tap(capText);
      await driver.enterText("23041");
      await driver.tap(numberText);
      await driver.enterText("34 a");
      await driver.tap(insertButton);
    });
    test('CAP not inserted doesnt allow to add a new shipping address',
        () async {
      await driver.tap(stateText);
      await driver.enterText("Italia");
      await driver.tap(addressText);
      await driver.enterText("Via Borch");
      await driver.tap(cityText);
      await driver.enterText("Livigno");
      await driver.tap(capText);
      await driver.enterText("");
      await driver.tap(numberText);
      await driver.enterText("34 a");
      await driver.tap(insertButton);
    });
    test('Number not inserted doesnt allow to add a new shipping address',
        () async {
      await driver.tap(stateText);
      await driver.enterText("Italia");
      await driver.tap(addressText);
      await driver.enterText("Via Borch");
      await driver.tap(cityText);
      await driver.enterText("Livigno");
      await driver.tap(capText);
      await driver.enterText("23041");
      await driver.tap(numberText);
      await driver.enterText("");
      await driver.tap(insertButton);
    });
    test('All data inserted allow to add a new shipping address', () async {
      await driver.tap(stateText);
      await driver.enterText("Italia");
      await driver.tap(addressText);
      await driver.enterText("Via Borch");
      await driver.tap(cityText);
      await driver.enterText("Livigno");
      await driver.tap(capText);
      await driver.enterText("23041");
      await driver.tap(numberText);
      await driver.enterText("34 a");
      await driver.tap(insertButton);
    });
  });
}
