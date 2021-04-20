import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/ShippingAddress.dart';

enum StatusPayment { Error, Done }

class CheckOutManager extends ChangeNotifier {
  CreditCard _selectedCreditCard = null;
  ShippingAddress _selectedShippingAddress = null;
  List<CreditCard> _listOfCreditCard;
  List<ShippingAddress> _listOfShippingAddress;
  List<Product> _listOfProductCart = null;
  StatusPayment _statusPayment;
  Map<Product, int> _productsAndQuantity;
  String _uid;
  CollectionReference addressShippingReference =
      FirebaseFirestore.instance.collection('ShippingAddress');
  CollectionReference creditCardsReference =
      FirebaseFirestore.instance.collection('CreditCard');
  CollectionReference cartReference =
      FirebaseFirestore.instance.collection('Cart-Products');
  CollectionReference orderReference =
      FirebaseFirestore.instance.collection('Order');

  CheckOutManager(this._uid);

  void _obtainShippingAddress() async {
    QuerySnapshot result =
        await addressShippingReference.where('uidUser', isEqualTo: _uid).get();

    _listOfShippingAddress = _shippingAddressListFromSnapshot(result);
  }

  List<ShippingAddress> _shippingAddressListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => ShippingAddress(
            doc.data()['state'] ?? '',
            doc.data()['address'] ?? '',
            doc.data()['city'] ?? '',
            doc.data()['cap'] ?? '',
            doc.data()['number'] ?? '',
            doc.data()['uidUser'] ?? ''))
        .toList();
  }

  void selectAddress(int index) {
    _selectedShippingAddress = _listOfShippingAddress.elementAt(index);
  }

  /**
   * Obtain the list of Credit Card from the DB and save it inside the object
   */
  void _obtainCreditCards() async {
    QuerySnapshot result =
        await creditCardsReference.where('uidUser', isEqualTo: _uid).get();

    _listOfCreditCard = _creditCardListFromSnapshot(result);
  }

  //Convert The querySnapshot that contains the credit Cards in a list
  //that contains those Credit cards
  //Precondition: The snapshot must contain the credit cards with the correct parameters
  List<CreditCard> _creditCardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => CreditCard(
              doc.data()['number'] ?? '',
              doc.data()['cvc'] ?? '',
              doc.data()['expDate'] ?? '',
            ))
        .toList();
  }

  void selectCreditCard(int index) {
    _selectedCreditCard = _listOfCreditCard.elementAt(index);
  }

  void _obtainAllProductInTheCart() async {
    QuerySnapshot result =
        await cartReference.where('uid', isEqualTo: _uid).get();

    _listOfProductCart = _productsInTheCartListFromSnapshot(result);
  }

  //Convert The querySnapshot that contains the products in the cart of a user in a list
  //that contains those products
  //Precondition: The snapshot must contain the products with the correct parameters
  List<Product> _productsInTheCartListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(
              doc.data()['supplier'] ?? '',
              doc.data()['type'] ?? '',
              doc.data()['name'] ?? '',
              doc.data()['price'] ?? '',
              doc.data()['quantity'] ?? '',
            ))
        .toList();
  }

  /**
   * This method is the first to call after that the checkout
   * manager has been created and it
   */
  void obtainAllDataForCheckout() async {
    await _obtainAllProductInTheCart();
    await _obtainCreditCards();
    await _obtainShippingAddress();
  }

  Future<StatusPayment> performPayment() async {
    //bool result = await Webservice().postPayment(_selectedCreditCard.number,
    // _selectedCreditCard.cvc, _selectedCreditCard.expDate);

    double totalPrice = 0.0;
    Map<String, int> productAndQuantity = {};
    Timestamp stamp =
        Timestamp.now(); // obtain a timestamp to insert in the order

    for (int i = 0; i < _listOfProductCart.length; i++) {
      //Calculate the total price and create the Map with the products and quantity to write in the DB
      totalPrice += _listOfProductCart.elementAt(i).price *
          _listOfProductCart.elementAt(i).quantity;
      productAndQuantity.putIfAbsent(_listOfProductCart.elementAt(i).name,
          () => _listOfProductCart.elementAt(i).quantity);
    }

    if (_selectedCreditCard != null &&
        _selectedShippingAddress != null &&
        _listOfProductCart != null) {
      await orderReference.add({
        'productAndQuantity': productAndQuantity,
        'time': stamp,
        'totalPrice': totalPrice,
        'uidUser': _uid
      });

      return StatusPayment.Done;
    } else {
      return StatusPayment.Error;
    }
  }

  get statusPayment => _statusPayment;
  get creditCards => _listOfCreditCard;
  get shippingAddress => _listOfShippingAddress;
  get productInTheCart => _listOfProductCart;
}
