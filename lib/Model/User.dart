import 'dart:convert';

import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/ShippingAddress.dart';

class User {
  final String _name;
  final String _surname;
  final String _nickname;
  String _password;
  var _listOfaddress;
  var _listOfCreditCard;
  var _listOfOrders;
  final Cart _cartOfTheUser;

  //Constructor
  User(this._name, this._surname, this._nickname, this._password,
      this._cartOfTheUser) {
    _listOfaddress = [];
    _listOfCreditCard = [];
    _listOfOrders = [];
  }

  //Getter
  String get name => _name;

  String get surname => _surname;

  String get nickname => _nickname;

  String get password => _password;

  get listOfAddress => [].addAll(_listOfaddress.iterator);

  get listOfCreditCard => [].addAll(_listOfCreditCard.iterator);

  get listOfOrders => [].addAll(_listOfOrders.iterator);

  get cart =>  

  //Setter
  set password(String password) {
    this._password = password;
  }

  set addShippingAddress(ShippingAddress address) {
    _listOfaddress.add(address);
  }

  set removeShippingAddress(ShippingAddress address) {
    _listOfaddress.remove(address);
  }

  set addCreditCard(CreditCard card) {
    _listOfCreditCard.add(card);
  }

  set removeCreditCard(CreditCard card) {
    _listOfCreditCard.remove(card);
  }

  //Utility
  User copyWith({
    String name,
    String surname,
    String nickname,
    String password,
  }) {
    return User(
      _name ?? this._name,
      _surname ?? this._surname,
      _nickname ?? this._nickname,
      _password ?? this._password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'surname': _surname,
      'nickname': _nickname,
      'password': _password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      map['name'],
      map['surname'],
      map['nickname'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(_name: $_name, _surname: $_surname, _nickname: $_nickname, _password: $_password)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o._name == _name &&
        o._surname == _surname &&
        o._nickname == _nickname &&
        o._password == _password;
  }

  @override
  int get hashCode {
    return _name.hashCode ^
        _surname.hashCode ^
        _nickname.hashCode ^
        _password.hashCode;
  }
}
