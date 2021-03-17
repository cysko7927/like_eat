import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class SearchManager extends ChangeNotifier {
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  List<Product> _listProductOfView = [];

  Future<void> searchProduct(String name, [String type, bool available]) async {
    Query result = await productsReference.where('searchKeyword',
        arrayContains:
            name); //Obtain the reference of the products that matches the name in input

    if (type != Null) {
      result = result.where('type',
          isEqualTo: type); //Filter the type of the product
    }

    if (available) {
      result = result.where('quantity',
          isGreaterThan: 0); //Filter the available products
    }

    _listProductOfView = _productsListFromSnapshot(
        await result.get()); //Write the list complete and update the state
  }

  ProductManager selectProductAndObtainAProductManager(int index) {
    Product product = _listProductOfView.elementAt(index);

    return ProductManager(
        product); //Insert the product with the info to show and return it
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
