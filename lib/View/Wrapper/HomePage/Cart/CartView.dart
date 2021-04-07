import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/CartManager.dart';
import 'package:like_eat/View/Wrapper/HomePage/Cart/CartList.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartManager cartManager = CartManager(FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Cart'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: null,
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Text("Cart"),
          Container(
            child: SizedBox(
              height: 400.0,
              child: CartList(),
            ),
          ),
        ])));
  }
}
