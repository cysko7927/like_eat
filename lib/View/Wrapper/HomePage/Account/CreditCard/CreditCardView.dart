import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/CreditCard/CreditCardList.dart';
import 'package:like_eat/ViewModel/CreditCardManager.dart';

class CreditCards extends StatefulWidget {
  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards> {
  List creditCards = [];

  //State variables
  String cvc = '';
  String expDate = '';
  String number = '';
  
  final _formKey = GlobalKey<FormState>();
  //Controllers
  TextEditingController cvcController = new TextEditingController();
  TextEditingController expDateController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();

  //Manager of View-Model
  CreditCardManager creditCardManager =
      CreditCardManager(FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Credit Card'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        child: Text("Add new Credit Card",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.blue))),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter the cvc" : null,
                          onChanged: (val) {
                            setState(() => cvc = val);
                          },
                          controller: cvcController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the CVC')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter the expiration Date" : null,
                          onChanged: (val) {
                            setState(() => expDate = val);
                          },
                          controller: expDateController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the expiration Date')),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter the number" : null,
                          onChanged: (val) {
                            setState(() => number = val);
                          },
                          controller: numberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the number')),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                        ),
                        child: FlatButton(
                          textColor: Colors.white,
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                creditCardManager.addCreditCard(number,cvc,expDate)
                              }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Insert new credit Card",
                                style: TextStyle(fontSize: 15.0),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            Row(
              children: [
                Expanded(child: SizedBox(height: 200.0, child: CreditCardList())),
              ],
            ),
          ],
        )));
  }
}
