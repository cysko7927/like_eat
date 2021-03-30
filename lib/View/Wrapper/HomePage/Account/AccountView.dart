import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool userIsOut = false;
  @override
  Widget build(BuildContext context) {
    // built the setting widget
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Password');
                },
                child: Row(
                  children: [
                    Icon(Icons.security),
                    Text(
                      "Change Password",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Email');
                },
                child: Row(
                  children: [
                    Icon(Icons.email),
                    Text(
                      "Change email",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: null,
                child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    Text(
                      "Change Profile Picture",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Address');
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(
                      "Manage shipping address",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'CreditCard');
                },
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    Text(
                      "Manage credit cards",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
