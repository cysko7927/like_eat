import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/ShippingAddress/AddressList.dart';
import 'package:like_eat/ViewModel/CheckoutManager.dart';
import 'package:like_eat/ViewModel/CreditCardManager.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  CheckOutManager checkOutManager;
  CheckOut(this.checkOutManager);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _formKey = GlobalKey<FormState>();
  CheckOutManager checkOutManager;
  List<ShippingAddress> addresses;
  List<CreditCard> cards;
  List<Product> cart;
  int indexCard;
  int indexAddress;

  @override
  Widget build(BuildContext context) {
    checkOutManager = widget.checkOutManager;
    addresses = checkOutManager.shippingAddress;
    cards = checkOutManager.creditCards;
    cart = checkOutManager.productInTheCart;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: Text('Check Out'),
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
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 30.0, right: 30, top: 20, bottom: 5),
                        child: Text("Select the credit card:",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black))),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 20, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 400.0,
                            child: CreditCardListCheckOut(cards),
                          )),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 30.0, right: 30, top: 20, bottom: 5),
                        child: Text("Select the Shipping Address:",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black))),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 20, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 400.0,
                            child: AddressListCheckOut(addresses),
                          )),
                        ],
                      ),
                    ),
                  ])))
        ])));
  }
}

class CreditCardListCheckOut extends StatefulWidget {
  List<CreditCard> cards;
  CreditCardListCheckOut(this.cards);
  @override
  _CreditCardListCheckOutState createState() => _CreditCardListCheckOutState();
}

class _CreditCardListCheckOutState extends State<CreditCardListCheckOut> {
  @override
  Widget build(BuildContext context) {
    final List<CreditCard> creditCard = widget.cards;
    return ListView.builder(
        itemCount: creditCard.length,
        itemBuilder: (context, index) {
          return CreditCardCheckOutTile(creditCard.elementAt(index), index);
        });
  }
}

class CreditCardCheckOutTile extends StatelessWidget {
  final CreditCard creditCard;
  final int index;

  CreditCardCheckOutTile(this.creditCard, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(creditCard.number),
            subtitle: Text(creditCard.cvc + " " + creditCard.expDate),
            trailing: Wrap(
              children: [
                IconButton(
                    icon: Icon(Icons.check_box_outline_blank), onPressed: () {})
              ],
            ),
          ),
        ));
  }
}

class AddressListCheckOut extends StatefulWidget {
  List<ShippingAddress> address;
  AddressListCheckOut(this.address);
  @override
  _AddressListCheckOutState createState() => _AddressListCheckOutState();
}

class _AddressListCheckOutState extends State<AddressListCheckOut> {
  @override
  Widget build(BuildContext context) {
    final List<ShippingAddress> address = widget.address;

    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return AddressTileCheckOut(address.elementAt(index), index);
        });
  }
}

class AddressTileCheckOut extends StatelessWidget {
  final ShippingAddress address;
  final int index;
  AddressTileCheckOut(this.address, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(address.address),
            subtitle: Text(address.number +
                " " +
                address.city +
                " " +
                address.cap +
                " " +
                address.state),
          ),
        ));
  }
}
