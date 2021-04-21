import 'dart:convert';

import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:like_eat/Model/ShippingAddress.dart';

class UserApp {
  final String _name;
  final String _surname;
  final String _nickname;
  final String _mail;
  String _password;
  List<ShippingAddress> _listOfaddress;
  List<CreditCard> _listOfCreditCard;
  List<Order> _listOfOrders;
  Cart _cartOfTheUser;
  List<Notifications> _listOfNotification;

  //Constructor
  UserApp(this._name, this._surname, this._nickname, this._mail) {
    _listOfaddress = [];
    _listOfCreditCard = [];
    _listOfOrders = [];
    _listOfNotification = [];
    _cartOfTheUser = null;
  }

  //Getter
  String get name => _name;

  String get surname => _surname;

  String get nickname => _nickname;

  String get password => _password;

  String get mail => _mail;

  get listOfAddress => [].addAll(_listOfaddress);

  get listOfCreditCard => [].addAll(_listOfCreditCard);

  get listOfOrders => [].addAll(_listOfOrders);

  get cart => _cartOfTheUser;

  get listOfNotification => [].addAll(_listOfNotification);

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

  set addOrder(Order order) {
    _listOfOrders.add(order);
  }

  set addNotification(Notifications notification) {
    _listOfNotification.add(notification);
  }

  set removeNotification(Notifications notification) {
    _listOfNotification.remove(notification);
  }
}

class UserAnon {
  final String uid;
  final bool isverified;
  final String email;

  UserAnon(this.uid, this.isverified, this.email);
}
