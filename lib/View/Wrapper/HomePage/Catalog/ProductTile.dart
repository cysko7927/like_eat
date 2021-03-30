import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/View/Wrapper/HomePage/ProductView.dart';
import 'package:like_eat/ViewModel/ObservedProductManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_eat/ViewModel/ProductManager.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
                title: Text(product.name),
                subtitle: Text("Qty: " +
                    product.quantity.toString() +
                    "\t" +
                    "by: " +
                    product.supplier),
                trailing: Text(product.price.toString() + "€"),
                onTap: () async {
                  var observedProduct = ObservedProductManager(
                      FirebaseAuth.instance.currentUser.uid);

                  //List<Object> obj = [];
                  //obj.add(product);
                  bool isObserved =
                      await observedProduct.productIsObserved(product);
                  //obj.add(isObserved);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider<Product>.value(
                            value: ProductManager(
                                    product,
                                    FirebaseAuth.instance.currentUser.uid,
                                    isObserved)
                                .productStream,
                            child: ProductDetail(isObserved))),
                  );
                })));
  }
}
