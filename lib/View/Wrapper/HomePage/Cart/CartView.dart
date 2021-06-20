import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/Product.dart';
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
          key: ValueKey("Cart_appBarKey"),
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
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: FlatButton(
              key: ValueKey("Cart_goToPayment_Button"),
              textColor: Colors.white,
              onPressed: () async {
                await checkOutManager.obtainAllDataForCheckout();
                List<Product> products = checkOutManager.productInTheCart;
                if (products.isEmpty) {
                  Widget okButton = FlatButton(
                    key: ValueKey("CheckOut_emptyCart_PopUp"),
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text("Cart Is empty"),
                    actions: [
                      okButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOut(checkOutManager)),
                  );
                }
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
