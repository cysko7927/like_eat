import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/User.dart';

class Order {
  Timestamp _time;
  Map<String, dynamic> _productAndQuantity;

  Order(this._time, Map<String, dynamic> mapCart) {
    _productAndQuantity = {};
    _productAndQuantity.addAll(mapCart);
  }

  //Getter
  Timestamp get time => _time;
  Map<String, dynamic> get productAndQuantity => createMapProduct();

  //Setter

  //Utility

  Map<String, dynamic> createMapProduct() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map.addAll(_productAndQuantity);
    return map;
  }
}
