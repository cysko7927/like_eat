import 'dart:convert';

import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/User.dart';

class Order {
  DateTime _time;
  User _user;
  Map<Product, int> _productAndQuantity;

  Order(this._time, this._user, Map<Product, int> mapCart) {
    _productAndQuantity = {};
    _productAndQuantity.addAll(mapCart);
  }

  //Getter
  DateTime get time => _time;
  User get user => _user;
  Map<Product, int> get productAndQuantity => createMapProduct();

  //Setter

  //Utility

  Map<Product, int> createMapProduct() {
    Map<Product, int> map = new Map<Product, int>();
    map.addAll(_productAndQuantity);
    return map;
  }
}
