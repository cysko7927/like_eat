import 'dart:convert';

import 'package:like_eat/Model/User.dart';

class ShippingAddress {
  String _state;
  String _address;
  String _city;
  int _cap;
  int _number;
  final UserApp _user;

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
  int get cap => _cap;
  int get number => _number;
  UserApp get user => _user;

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

  set cap(int cap) {
    _cap = cap;
  }

  set number(int number) {
    _number = number;
  }
}
