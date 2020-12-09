import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class CartManager extends ChangeNotifier {
  Cart _cart;

  void insertProductInTheCart(String name, String type, String supplier,
      String nickname, int quantity) async {
    Webservice().postCart(name, type, supplier, nickname, quantity);
  }

  //ToDo
  //Fare operazioni mostra carrello  e rimuovi oggetti dal carrello
}
