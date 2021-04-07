import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';

import 'package:like_eat/ViewModel/CartManager.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<List<Product>>(context);
    if (products != null) {
      return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return CartTile(products.elementAt(index), index);
          });
    } else {
      return ListView.builder(
          itemCount: new List<Product>().length,
          itemBuilder: (context, index) {
            return CartTile(products[index], index);
          });
    }
  }
}

class CartTile extends StatelessWidget {
  final Product products;
  final int index;
  CartTile(this.products, this.index);

  CartManager cartManager = CartManager(FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(products.name),
              subtitle: Text("Qty: " +
                  products.quantity.toString() +
                  "\t" +
                  "by: " +
                  products.supplier),
              trailing: Row(children: [
                Text(products.price.toString() + "€"),
                Wrap(
                  children: [
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartManager.removeProductInTheCart(products);
                        })
                  ],
                )
              ])),
        ));
  }
}
