import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class SearchManager extends ChangeNotifier {
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  List<Product> _listProductOfView = new List<Product>();
  Stream<QuerySnapshot> _snapshot;
  String _type;
  bool _available;

  /**
   * Search the products in the DB and save the stream and the list of the searched product
   */
  Future<void> searchProduct(String name, [String type, bool available]) async {
    Query result = await productsReference.where('searchKeyword',
        arrayContains:
            name); //Obtain the reference of the products that matches the name in input

    List<Product> allProducts = _productsListFromSnapshot(await result.get());
    _snapshot = result.snapshots();

    _type = type;
    _available =
        available; //Save the option of Filter for the stream of products

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

  /**
   * Is equal at the method before but filters also the products
   */
  List<Product> _productsListForStreamFromSnapshot(QuerySnapshot snapshot) {
    List<Product> list = snapshot.docs
        .map((doc) => Product(
              doc.data()['supplier'] ?? '',
              doc.data()['type'] ?? '',
              doc.data()['name'] ?? '',
              doc.data()['price'] ?? '',
              doc.data()['quantity'] ?? '',
            ))
        .toList();

    if (_type != "All") {
      list = list.where((product) => product.type == _type).toList();
      //Filter the type of the product
    }

    if (_available) {
      list = //Filter the available products
          list.where((product) => product.quantity > 0).toList();
    }

    return list;
  }

  //obtain the stream of the list of product searched
  Stream<List<Product>> get productsStream {
    if (_snapshot == null)
      return null;
    else
      return _snapshot.map(_productsListForStreamFromSnapshot);
  }
  //Getter

  List<Product> get products => _listProductOfView;
}
