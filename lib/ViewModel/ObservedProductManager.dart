import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class ObservedProductManager extends ChangeNotifier {
  List<Product> _observedproducts;
  CollectionReference productsObservedReference =
      FirebaseFirestore.instance.collection('User-ProductObserved');
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  String _uid;

  ObservedProductManager(this._uid);

  //void obtainObservedProduct() async {} Non serve per il momento

  void insertOrRemoveProduct(Product product, bool observed) async {
    if (observed) {
      QuerySnapshot result = await productsObservedReference
          .where('nameProduct', isEqualTo: product.name)
          .where('typeProduct', isEqualTo: product.type)
          .where('supplierProduct', isEqualTo: product.supplier)
          .where('uid', isEqualTo: _uid)
          .get(); //obtain the reference of the product observed from DB

      productsObservedReference
          .doc(result.docs.elementAt(0).id)
          .delete(); //Delete the product observed from the list in the DB

    } else {
      productsObservedReference.add({
        'nameProduct': product.name,
        'supplierProduct': product.supplier,
        'typeProduct': product.type,
        'uid': _uid,
      }); //Add the product in the list of observed product of the user in the DB

    }
  }

  Future<bool> productIsObserved(Product product) async {
    QuerySnapshot result = await productsObservedReference
        .where('nameProduct', isEqualTo: product.name)
        .where('typeProduct', isEqualTo: product.type)
        .where('supplierProduct', isEqualTo: product.supplier)
        .where('uid', isEqualTo: _uid)
        .get();

    if (result.docs.isEmpty)
      return false;
    else
      return true;
  }

  //obtain the stream of the list of the observed products of the user with uid = _uid from this class
  Stream<List<Product>> get productsObserved {
    return productsObservedReference
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map(_productsObservedListFromSnapshot);
  }

  //Convert The querySnapshot that contains the observed products of a user in a list
  //that contains those products
  //Precondition: The snapshot must contain the products with the correct parameters
  List<Product> _productsObservedListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(
            doc.data()['supplierProduct'] ?? '',
            doc.data()['typeProduct'] ?? '',
            doc.data()['nameProduct'] ?? '',
            0,
            0))
        .toList();
  }
}
