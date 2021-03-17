import 'dart:convert';

import 'package:like_eat/Model/User.dart';

class CreditCard {
  String _number;
  String _cvc;
  String _expDate;

  //Constructor
  CreditCard(
    this._number,
    this._cvc,
    this._expDate,
  );

  //Getter
  String get number => _number;
  String get cvc => _cvc;
  String get expDate => _expDate;

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
}
