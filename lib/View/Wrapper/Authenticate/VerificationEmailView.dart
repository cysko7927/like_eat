import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';

class VerificationEmail extends StatefulWidget {
  String email;
  VerificationEmail(this.email);
  @override
  _VerificationEmailState createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  final AuthService _auth = AuthService();
  String email;

  @override
  Widget build(BuildContext context) {
    email = widget.email;
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Email Not Verified'),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 5),
            child: Text(
                "Your email is not verified.\nPlease check your email box and verify it",
                style: TextStyle(fontSize: 20.0, color: Colors.black))),
        Container(
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 20, bottom: 5),
            child: Text(
                "If you have not recieved the email, please click the button below and another email it will be sent",
                style: TextStyle(fontSize: 20.0, color: Colors.black))),
        Container(
          child: FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            onPressed: () async {
              _auth.sendVerificationEmailLink(email);

              Widget okButton = FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );

              // Create AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Email sent"),
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
            },
            child: Text(
              "Send Email",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ])),
    );
  }
}
