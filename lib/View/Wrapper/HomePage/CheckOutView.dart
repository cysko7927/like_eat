import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/ShippingAddress/AddressList.dart';
import 'package:like_eat/ViewModel/CheckoutManager.dart';
import 'package:like_eat/ViewModel/CreditCardManager.dart';
import 'package:provider/provider.dart';

int globalCardIndex = -1;
int globalAddressIndex = -1;

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
                            key: ValueKey("CheckOut_card_tile"),
                            height: 200.0,
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
                            key: ValueKey("CheckOut_address_tile"),
                            height: 200.0,
                            child: AddressListCheckOut(addresses),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: FlatButton(
                        key: ValueKey("CheckOut_proceedPayment_button"),
                        textColor: Colors.white,
                        onPressed: () async {
                          if (globalAddressIndex == -1 ||
                              globalCardIndex == -1) {
                            Widget okButton = FlatButton(
                              key: ValueKey("CheckOut_selectStuff_PopUp"),
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: Text(
                                  "Please select a Shipping Address and a Credit Card"),
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
                            checkOutManager.selectCreditCard(globalCardIndex);
                            checkOutManager.selectAddress(globalAddressIndex);

                            StatusPayment status =
                                await checkOutManager.performPayment();

                            Widget okButton = FlatButton(
                              key: ValueKey("CheckOut_ok_PopUp"),
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'HomePage',
                                    ModalRoute.withName('HomePage'));
                              },
                            );
                            if (obtainString(status) == "Payment Done") {
                              // Create AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Order Accepted"),
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
                              // Create AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text(obtainString(status)),
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
                            }
                          }
                        },
                        child: Text(
                          "Pay and Order",
                          style: TextStyle(fontSize: 15.0),
                        ),
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
  int indexSelected;
  @override
  Widget build(BuildContext context) {
    final List<CreditCard> creditCard = widget.cards;
    return ListView.builder(
      itemCount: creditCard.length,
      itemBuilder: (context, index) {
        return RadioListTile(
          groupValue: indexSelected,
          title: Text(creditCard.elementAt(index).number),
          value: index,
          onChanged: (val) {
            setState(() {
              indexSelected = val;
              globalCardIndex = val;
            });
          },
        );
      },
    );
  }
}

class AddressListCheckOut extends StatefulWidget {
  List<ShippingAddress> address;
  AddressListCheckOut(this.address);
  @override
  _AddressListCheckOutState createState() => _AddressListCheckOutState();
}

class _AddressListCheckOutState extends State<AddressListCheckOut> {
  int indexSelected;
  @override
  Widget build(BuildContext context) {
    final List<ShippingAddress> address = widget.address;

    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            groupValue: indexSelected,
            title: Text(address.elementAt(index).address +
                " " +
                address.elementAt(index).number +
                " " +
                address.elementAt(index).city +
                " " +
                address.elementAt(index).cap +
                " " +
                address.elementAt(index).state),
            value: index,
            onChanged: (val) {
              setState(() {
                indexSelected = val;
                globalAddressIndex = val;
              });
            },
          );
        });
  }
}

String obtainString(StatusPayment status) {
  switch (status) {
    case StatusPayment.Error:
      return "Payment Error";
      break;
    case StatusPayment.Done:
      return "Payment Done";
      break;
  }
}
