import 'dart:convert';

import 'package:like_eat/Model/User.dart';

class ShippingAddress {
  String _state;
  String _address;
  String _city;
  int _cap;
  int _number;
  final User _user;

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
  User get user => _user;

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

  //Utility
  ShippingAddress copyWith({
    String state,
    String address,
    String city,
    int cap,
    int number,
    User user,
  }) {
    return ShippingAddress(
      _state ?? this._state,
      _address ?? this._address,
      _city ?? this._city,
      _cap ?? this._cap,
      _number ?? this._number,
      _user ?? this._user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_state': _state,
      '_address': _address,
      '_city': _city,
      '_cap': _cap,
      '_number': _number,
      '_user': _user?.toMap(),
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ShippingAddress(
      map['_state'],
      map['_address'],
      map['_city'],
      map['_cap'],
      map['_number'],
      User.fromMap(map['_user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromJson(String source) =>
      ShippingAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShippingAddress(_state: $_state, _address: $_address, _city: $_city, _cap: $_cap, _number: $_number, _user: $_user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ShippingAddress &&
        o._state == _state &&
        o._address == _address &&
        o._city == _city &&
        o._cap == _cap &&
        o._number == _number &&
        o._user == _user;
  }

  @override
  int get hashCode {
    return _state.hashCode ^
        _address.hashCode ^
        _city.hashCode ^
        _cap.hashCode ^
        _number.hashCode ^
        _user.hashCode;
  }
}
