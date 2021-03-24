import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/User.dart';

class Order {
  Timestamp _time;
  Map<Product, int> _productAndQuantity;

  Order(this._time, Map<Product, int> mapCart) {
    _productAndQuantity = {};
    _productAndQuantity.addAll(mapCart);
  }

  //Getter
  Timestamp get time => _time;
  Map<Product, int> get productAndQuantity => createMapProduct();

  //Setter

  //Utility

  Map<Product, int> createMapProduct() {
    Map<Product, int> map = new Map<Product, int>();
    map.addAll(_productAndQuantity);
    return map;
  }
}
