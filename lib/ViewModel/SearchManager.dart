import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class SearchManager extends ChangeNotifier {
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  List<Product> _listProductOfView = new List<Product>();

  Future<void> searchProduct(String name, [String type, bool available]) async {
    Query result = await productsReference.where('searchKeyword',
        arrayContains:
            name); //Obtain the reference of the products that matches the name in input

    List<Product> allProducts = _productsListFromSnapshot(await result.get());

    if (type != "All") {
      allProducts =
          allProducts.where((product) => product.type == type).toList();
      //Filter the type of the product
    }

    if (available) {
      allProducts = //Filter the available products
          allProducts.where((product) => product.quantity > 0).toList();
    }

    _listProductOfView = new List<Product>();
    _listProductOfView
        .addAll(allProducts); //Write the list complete and update the state
  }

  //Convert The querySnapshot that contains the Products in a list
  //that contains those Products
  //Precondition: The snapshot must contain the Products with the correct parameters
  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(
              doc.data()['supplier'] ?? '',
              doc.data()['type'] ?? '',
              doc.data()['name'] ?? '',
              doc.data()['price'] ?? '',
              doc.data()['quantity'] ?? '',
            ))
        .toList();
  }

  //Getter

  List<Product> get products => _listProductOfView;
}
