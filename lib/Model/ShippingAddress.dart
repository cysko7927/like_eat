import 'dart:convert';

import 'package:like_eat/Model/User.dart';

class ShippingAddress {
  String _state;
  String _address;
  String _city;
  String _cap;
  String _number;
  final String _user;

  //Constructor
  ShippingAddress(
    this._state,
    this._address,
    this._city,
    this._cap,
    this._number,
    this._user,
  );

  //Getter

  String get state => _state;
  String get city => _city;
  String get address => _address;
  String get cap => _cap;
  String get number => _number;
  String get user => _user;

  //Setter

  set state(String state) {
    _state = state;
  }

  set city(String city) {
    _city = city;
  }

  set address(String address) {
    _address = address;
  }

  set cap(String cap) {
    _cap = cap;
  }

  set number(String number) {
    _number = number;
  }
}
