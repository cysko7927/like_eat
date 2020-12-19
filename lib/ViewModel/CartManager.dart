import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class CartManager extends ChangeNotifier {
  Cart _cart;

  void obtainCart() async {
    _cart =
        await Webservice().fetchCart(ViewModel.userDataManager.user.nickname);
    notifyListeners();
  }

  void insertProductInTheCart(
      String name, String type, String supplier, int quantity) async {
    Webservice().postAddCart(name, type, supplier,
        ViewModel.userDataManager.user.nickname, quantity);
    obtainCart();
    notifyListeners();
  }

  void removeProductInTheCart(int index) {
    Product selected = _cart.productsInCart.elementAt(index);
    Webservice().postRemoveCart(selected.name, selected.type, selected.type,
        ViewModel.userDataManager.user.nickname);

    obtainCart();
    notifyListeners();
  }

  void updateQuanityCart(int index, int quantity) {
    Product selected = _cart.productsInCart.elementAt(index);

    Webservice().postUpdateCart(selected.name, selected.type, selected.type,
        ViewModel.userDataManager.user.nickname, quantity);

    obtainCart();
    notifyListeners();
  }

  //Serve un metodo per ottenere i prodotti e la quantità del carello

  get allTheCart => _cart.productAndQuantity;
}
