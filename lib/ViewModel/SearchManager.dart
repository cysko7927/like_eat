import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class SearchManager extends ChangeNotifier {
  List<Product> _listProductOfView = [];

  Future<void> searchProduct(String name, [String type, bool available]) async {
    List<Product> result = await Webservice()
        .fetchProducts(name); //Take the products from the server

    if (type != Null) {
      result = result.where(
          (element) => element.type == type); //Filter the type of the product
    }

    if (available) {
      result = result.where(
          (element) => element.quantity > 0); //Filter the available products
    }

    _listProductOfView = result; //Write the list complete

    notifyListeners(); //Commit State for the view
  }

  ProductManager selectProductAndObtainAProductManager(int index) {
    Product product = _listProductOfView.elementAt(index);

    return ProductManager(
        product); //Insert the product with the info to show and return it
  }

  //Getter

  List<Product> get products => _listProductOfView;
}
