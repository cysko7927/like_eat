import 'dart:convert';

import 'package:like_eat/Model/User.dart';

class CreditCard {
  String _number;
  String _cvc;
  String _expDate;
  User _user;

  //Constructor
  CreditCard(
    this._number,
    this._cvc,
    this._expDate,
    this._user,
  );

  //Getter
  String get number => _number;
  String get cvc => _cvc;
  String get expDate => _expDate;
  User get user => _user;

  //Setter

  set number(String number) {
    _number = number;
  }

  set cvc(String cvc) {
    _cvc = cvc;
  }

  set expDate(String expDate) {
    _expDate = expDate;
  }

  //Utility
  CreditCard copyWith({
    String number,
    String cvc,
    String expDate,
    User user,
  }) {
    return CreditCard(
      _number ?? this._number,
      _cvc ?? this._cvc,
      _expDate ?? this._expDate,
      _user ?? this._user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': _number,
      'cvc': _cvc,
      'expDate': _expDate,
      'user': _user?.toMap(),
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CreditCard(
      map['_number'],
      map['_cvc'],
      map['_expDate'],
      User.fromMap(map['_user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) =>
      CreditCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditCard(_number: $_number, _cvc: $_cvc, _expDate: $_expDate, _user: $_user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreditCard &&
        o._number == _number &&
        o._cvc == _cvc &&
        o._expDate == _expDate &&
        o._user == _user;
  }

  @override
  int get hashCode {
    return _number.hashCode ^
        _cvc.hashCode ^
        _expDate.hashCode ^
        _user.hashCode;
  }
}
