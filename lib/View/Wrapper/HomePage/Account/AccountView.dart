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
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Password');
                },
                child: Row(
                  children: [
                    Icon(Icons.security),
                    SizedBox(width: 10),
                    Text(
                      "Change Password",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Email');
                },
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text(
                      "Change email",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Nickname');
                },
                child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 10),
                    Text(
                      "Change Nickname",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'Address');
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 10),
                    Text(
                      "Manage shipping address",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          Container(
              margin:
                  EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'CreditCard');
                },
                child: Row(
                  children: [
                    Icon(Icons.credit_card),
                    SizedBox(width: 10),
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
