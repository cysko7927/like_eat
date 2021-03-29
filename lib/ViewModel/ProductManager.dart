import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ObservedProductManager.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';

class ProductManager {
  Product _productToShow;
  bool _observed;
  CollectionReference cartReference =
      FirebaseFirestore.instance.collection('Cart-Products');
  CollectionReference productsObservedReference =
      FirebaseFirestore.instance.collection('User-ProductObserved');
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  String _uid;

  ProductManager.empty() {}
  ProductManager(Product product, String uid, bool observed) {
    _productToShow = product; //Save the info of the product to show
    _uid = uid;
    _observed = observed;
  }

  //Add in the cart a product with a specified quantity choose by user
  //Precondition: the quantity must be correct(>= 0 and <= quantity of the product in the magazine)
  void addInTheCart(int quantity) async {
    QuerySnapshot result = await productsReference
        .where('name', isEqualTo: _productToShow.name)
        .where('type', isEqualTo: _productToShow.type)
        .where('supplier', isEqualTo: _productToShow.supplier)
        .get(); //obtain the reference of the product from DB

    productsReference.doc(result.docs.elementAt(0).id).update({
      'quantity': _productToShow.quantity - quantity
    }); //Update the quantity of the product in the DB

    cartReference.add({
      'name': _productToShow.name,
      'price': _productToShow.price,
      'quantity': quantity,
      'supplier': _productToShow.supplier,
      'type': _productToShow.type,
      'uid': _uid,
    }); //Add the product in the Cart of the user in the DB
  }

  /**
   * Change the state of the product to observable to not observable and so on,
   * inserting the product in the list of the observed product of the user
   */
  void modifyObservable() async {
    if (_observed) {
      QuerySnapshot result = await productsObservedReference
          .where('nameProduct', isEqualTo: _productToShow.name)
          .where('typeProduct', isEqualTo: _productToShow.type)
          .where('supplierProduct', isEqualTo: _productToShow.supplier)
          .where('uid', isEqualTo: _uid)
          .get(); //obtain the reference of the product observed from DB

      productsReference
          .doc(result.docs.elementAt(0).id)
          .delete(); //Delete the product observed from the list in the DB

      _observed = false;
    } else {
      productsObservedReference.add({
        'nameProduct': _productToShow.name,
        'supplierProduct': _productToShow.supplier,
        'typeProduct': _productToShow.type,
        'uid': _uid,
      }); //Add the product in the list of observed product of the user in the DB

      _observed = true;
    }
  }

  //obtain the stream of the product with a specific name,type,supplier from this class
  Stream<Product> get productStream {
    return productsReference
        .where('name', isEqualTo: product.name)
        .where('type', isEqualTo: product.type)
        .where('supplier', isEqualTo: product.supplier)
        .snapshots()
        .map(_productFromSnapshot);
  }

  //Convert The querySnapshot that contains a product in a object Product
  //Precondition: The snapshot must contain the Product with the correct parameters
  Product _productFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(
              doc.data()['supplier'] ?? '',
              doc.data()['type'] ?? '',
              doc.data()['name'] ?? '',
              doc.data()['price'] ?? '',
              doc.data()['quantity'] ?? '',
            ))
        .toList()
        .first;
  }

  //Fare i relativi getter per far si che il widget possa leggere i dati del prodotto

  Product get product => _productToShow;
  bool get isObserved => _observed;
}
