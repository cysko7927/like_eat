import 'dart:convert';

import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/User.dart';

class Order {
  String _time;
  Map<Product, int> _productAndQuantity;

  Order(this._time, Map<Product, int> mapCart) {
    _productAndQuantity = {};
    _productAndQuantity.addAll(mapCart);
  }

  //Getter
  String get time => _time;
  Map<Product, int> get productAndQuantity => createMapProduct();

  //Setter

  //Utility

  Map<Product, int> createMapProduct() {
    Map<Product, int> map = new Map<Product, int>();
    map.addAll(_productAndQuantity);
    return map;
  }
}
