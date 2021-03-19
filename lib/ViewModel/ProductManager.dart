import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_eat/Model/Product.dart';
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

  ProductManager(Product product) {
    _productToShow = product; //Save the info of the product to show
  }

  //Add in the cart a product with a specified quantity choose by user
  void addInTheCart(int quantity) {
    ViewModel.cartManager.insertProductInTheCart(_productToShow.name,
        _productToShow.type, _productToShow.supplier, quantity);
  }

  void modifyObservable() {
    ViewModel.observedProductManager.insertOrRemoveProduct(
        _productToShow.name,
        _productToShow.type,
        _productToShow.supplier,
        ViewModel.userDataManager.user.nickname,
        !_observed);
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
