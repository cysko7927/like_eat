import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:like_eat/View/Wrapper/HomePage/History/HistoryView.dart';
import 'package:test/test.dart';

void main() {
  group('Catalog Tests', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final catalogButton = find.byValueKey("Home_catalogButton");
    final observedButton = find.byValueKey("Home_ObservedButton");
    final cartButton = find.byValueKey("Home_cartButton");
    final historyButton = find.byValueKey("Home_historyButton");

    final inputText = find.byValueKey("Catalog_product_inputText");
    final productTile = find.byValueKey("Product_product_tile");

    final productButton = find.byValueKey("Product_addToCart_button");
    final cartIcon = find.byValueKey("Product_cart_icon");
    final observedIcon = find.byValueKey("Product_observed_icon");
    final productQuantitySlider = find.byValueKey("Product_quantity_slider");
    final productBackIcon = find.byValueKey("Product_backIcon");

    final cartGoToPayment = find.byValueKey("Cart_goToPayment_Button");
    final cartPopUpEmpty = find.byValueKey("CheckOut_emptyCart_PopUp");

    final checkOutCardTile = find.byValueKey("CheckOut_card_tile");
    final checkOutAddressTile = find.byValueKey("CheckOut_address_tile");

    final checkOutPopUpError = find.byValueKey("CheckOut_selectStuff_PopUp");
    final checkOutPopUpOk = find.byValueKey("CheckOut_ok_PopUp");
    final checkOutPaymentButton =
        find.byValueKey("CheckOut_proceedPayment_button");

    final cartAppBar = find.byValueKey("Cart_appBarKey");

    final catalogAppBar = find.byValueKey("Catalog_appBarKey");

    final observedAppBar = find.byValueKey("Observed_appBarKey");

    final historyAppBar = find.byValueKey("History_appBarKey");

    final catalogBack = find.descendant(
      of: catalogAppBar,
      matching: find.byType('BackButton'),
      firstMatchOnly: true,
    );
    final cartBack = find.descendant(
      of: cartAppBar,
      matching: find.byType('BackButton'),
      firstMatchOnly: true,
    );

    final observedBack = find.descendant(
      of: observedAppBar,
      matching: find.byType('BackButton'),
      firstMatchOnly: true,
    );
    final historyBack = find.descendant(
      of: historyAppBar,
      matching: find.byType('BackButton'),
      firstMatchOnly: true,
    );

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
    test('check cart that is empty', () async {
      await driver.tap(cartButton);
      await driver.tap(cartBack);
    });
    test('You cannot continue with the payment if cart is empty', () async {
      await driver.tap(cartButton);
      await driver.tap(cartGoToPayment);
      await driver.tap(cartPopUpEmpty);
      await driver.tap(cartBack);
    });
    test('Put a Product in the cart', () async {
      await driver.tap(catalogButton);
      await driver.tap(inputText);
      await driver.enterText("prova");
      await driver.tap(productTile);
      await driver.tap(productQuantitySlider);
      await driver.tap(productButton);
      await driver.tap(cartIcon);
      await driver.tap(cartBack);
      await driver.tap(productBackIcon);
      await driver.tap(catalogBack);
    });
    test('Check cart not empty anymore', () async {
      await driver.tap(cartButton);
      await driver.tap(cartBack);
    });

    test('Search a Product, add it to the observed and check if is added',
        () async {
      await driver.tap(catalogButton);
      await driver.tap(inputText);
      await driver.enterText("apple");
      await driver.tap(productTile);
      await driver.tap(observedIcon);
      await driver.tap(productBackIcon);
      await driver.tap(catalogBack);
      await driver.tap(observedButton);
      await driver.tap(observedBack);
    });
    test(
        'Search a Product, remove it from the observed and check if is deleted from Observed List',
        () async {
      await driver.tap(catalogButton);
      await driver.tap(inputText);
      await driver.enterText("apple");
      await driver.tap(productTile);
      await driver.tap(observedIcon);
      await driver.tap(productBackIcon);
      await driver.tap(catalogBack);
      await driver.tap(observedButton);
      await driver.tap(observedBack);
    });
    test('Do an Order', () async {
      await driver.tap(historyButton);
      await driver.tap(historyBack);
      await driver.tap(cartButton);
      await driver.tap(cartGoToPayment);
      await driver.tap(checkOutPaymentButton);
      await driver.tap(checkOutPopUpError);
      await driver.tap(checkOutCardTile);
      await driver.tap(checkOutAddressTile);
      await driver.tap(checkOutPaymentButton);
      await driver.tap(checkOutPopUpOk);
    });
  });
}
