import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Cart.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class CartManager extends ChangeNotifier {
  Cart _cart;
  CollectionReference cartReference =
      FirebaseFirestore.instance.collection('Cart-Products');
  CollectionReference productsReference =
      FirebaseFirestore.instance.collection('Product');
  String _uid;

  CartManager(this._uid);

  void obtainCart() async {}

  /*void insertProductInTheCart(
      String name, String type, String supplier, int quantity) async {
    Webservice().postAddCart(name, type, supplier,
        ViewModel.userDataManager.user.nickname, quantity);
    obtainCart();
    notifyListeners();
  }*/ //Per il momento non serve

  void removeProductInTheCart(Product product) async {
    //obtain the reference to the product in the Cart to remove from the DB
    QuerySnapshot result = await cartReference
        .where('name', isEqualTo: product.name)
        .where('price', isEqualTo: product.price)
        .where('quantity', isEqualTo: product.quantity)
        .where('supplier', isEqualTo: product.supplier)
        .where('type', isEqualTo: product.type)
        .where('uid', isEqualTo: _uid)
        .get();

    cartReference
        .doc(result.docs.elementAt(0).id)
        .delete(); //Remove the selected product from the cart interacting with the DB

    result = await productsReference
        .where('name', isEqualTo: product.name)
        .where('type', isEqualTo: product.type)
        .where('supplier', isEqualTo: product.supplier)
        .get(); //obtain the reference of the product from DB

    productsReference.doc(result.docs.elementAt(0).id).update({
      'quantity': product.quantity + result.docs.elementAt(0).data()['quantity']
    }); //Update the quantity of the product in the DB(quantity in the cart + residual quantity in the magazine )
  }

  /**
   * Update the quantity of the product in the cart in input,the quantity in input is the 
   * quantity to add(positive) or to remove (negative)
   * Precondition:The quantity in input must be correct and it must not lead 
   * the quantity in the Magazine to be negative and -product.quantity < quantity <= quantity in the magazine
   */
  void updateQuantityCart(Product product, int quantity) async {
    QuerySnapshot productMagazine = await productsReference
        .where('name', isEqualTo: product.name)
        .where('type', isEqualTo: product.type)
        .where('supplier', isEqualTo: product.supplier)
        .get(); //obtain the reference of the product from DB(Magazine)

    QuerySnapshot productCart = await cartReference
        .where('name', isEqualTo: product.name)
        .where('price', isEqualTo: product.price)
        .where('quantity', isEqualTo: product.quantity)
        .where('supplier', isEqualTo: product.supplier)
        .where('type', isEqualTo: product.type)
        .where('uid', isEqualTo: _uid)
        .get(); //obtain the reference of the product from DB(Cart)

    num quantityMagazine = productMagazine.docs.elementAt(0).data()['quantity'];

    productsReference.doc(productMagazine.docs.elementAt(0).id).update({
      'quantity': quantityMagazine - quantity
    }); //Update the quantity of the product in the DB(residual quantity in the magazine -quantity in the cart)

    cartReference.doc(productCart.docs.elementAt(0).id).update({
      'quantity': productCart.docs.elementAt(0).data()['quantity'] + quantity
    }); //Update the quantity of the product in the Cart in the DB(quantity in the cart + quantity added)
  }

  //obtain the stream of the list of the products in the cart of the user with uid = _uid from this class
  Stream<List<Product>> get productsInCart {
    return cartReference
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map(_productsInTheCartListFromSnapshot);
  }

  //Convert The querySnapshot that contains the products in the cart of a user in a list
  //that contains those products
  //Precondition: The snapshot must contain the products with the correct parameters
  List<Product> _productsInTheCartListFromSnapshot(QuerySnapshot snapshot) {
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
   * Returns the quantity of a product from the magazine
   */
  Future<num> obtainQuantityMagazineOfAProduct(Product product) async {
    QuerySnapshot result = await productsReference
        .where('name', isEqualTo: product.name)
        .where('type', isEqualTo: product.type)
        .where('supplier', isEqualTo: product.supplier)
        .get(); //obtain the reference of the product from DB

    return result.docs
        .elementAt(0)
        .data()['quantity']; //obtain the quantity in magazine
  }

  get allTheCart => _cart.productAndQuantity;
}
