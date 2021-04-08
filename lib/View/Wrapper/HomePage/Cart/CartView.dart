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
        backgroundColor: Colors.lightBlue[100],
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
          Container(
            child: SizedBox(
              height: 400.0,
              child: CartList(),
            ),
          ),
          Container(
            child: Text("TOTAL: ..."),
            //TODO:
            //Create a function in the cartManager that gives back the total of the cart
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(),
            ),
            child: FlatButton(
              textColor: Colors.white,
              onPressed: () async {},
              child: Text(
                "Proceed with the payment",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ])));
  }
}
