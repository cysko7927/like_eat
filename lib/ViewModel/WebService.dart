import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
//import 'package:http/http.dart' as http;
import 'package:like_eat/Model/User.dart';

class Webservice {
  Future<List<Product>> fetchProducts(String keyword) async {
    /*final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body["Search"];
      return json.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }*/
  }

  Future<List<Notifications>> fetchNotifications(String keyword) async {}

  Future<List<Order>> fetchHistory(String keyword) async {}

  Future<User> fetchUserData(String keyword) async {}

  Future<Cart> fetchCart(String nickname) async {}

  Future<void> postAddCart(String name, String type, String supplier,
      String nickname, int quantity) async {}

  Future<void> postRemoveCart(
      String name, String type, String supplier, String nickname) async {}

  Future<void> postUpdateCart(String name, String type, String supplier,
      String nickname, int quantity) async {}

  Future<void> postNewNickName(String newNick, String oldNick) async {}

  Future<bool> checkNewNickName(String newNick, String oldNick) async {}

  Future<void> postNewPassword(String newPassword, String nick) async {}

  Future<void> postNewNameAndSurname(
      String newName, String newSurname, String nickName) async {}

  Future<List<ShippingAddress>> fetchShippingAddress(String nickname) async {}

  Future<void> postAddShippingAddress(String state, String address, String city,
      int cap, int number, String nickname) async {}

  Future<void> postRemoveShippingAddress(String state, String address,
      String city, int cap, int number, String nickname) async {}

  Future<List<CreditCard>> fetchCreditCards(String nickname) async {}

  Future<void> postAddCreditCard(
      String number, String cvc, String expDate, String nick) async {}

  Future<void> postRemoveCreditCard(
      String number, String cvc, String expDate, String nick) async {}

  Future<List<Product>> fetchObservedProducts(String nickname) async {}

  Future<void> postFlagObservable(String name, String type, String supplier,
      String nickname, bool observed) async {}
}
