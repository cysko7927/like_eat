import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/CartManager.dart';
import 'package:like_eat/View/Wrapper/HomePage/Cart/CartList.dart';
import 'package:like_eat/View/Wrapper/HomePage/CheckOutView.dart';
import 'package:like_eat/ViewModel/CheckoutManager.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartManager cartManager = CartManager(FirebaseAuth.instance.currentUser.uid);
  CheckOutManager checkOutManager =
      CheckOutManager(FirebaseAuth.instance.currentUser.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Cart'),
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
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                await checkOutManager.obtainAllDataForCheckout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOut(checkOutManager)),
                );
              },
              child: Text(
                "Proceed with the payment",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ])));
  }
}
