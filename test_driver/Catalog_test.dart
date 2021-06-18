import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Catalog Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final inputText = find.byValueKey("Catalog_product_inputText");
    final productTile = find.byValueKey("Product_product_tile");
    final catalogButton = find.byValueKey("Home_catalogButton");

    final productButton = find.byValueKey("Product_addToCart_button");
    final cartIcon = find.byValueKey("Product_cart_icon");
    final observedIcon = find.byValueKey("Product_observed_icon");

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

    test('Search a Product', () async {
      await driver.tap(catalogButton);
      await driver.tap(inputText);
      await driver.enterText("prova");
      await driver.tap(productTile);
      await driver.tap(productButton);
      await driver.tap(cartIcon);
    });
  });
}
