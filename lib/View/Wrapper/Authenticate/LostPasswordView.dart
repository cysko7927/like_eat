import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';

class LostPassword extends StatefulWidget {
  @override
  _LostPasswordState createState() => _LostPasswordState();
}

class _LostPasswordState extends State<LostPassword> {
  final AuthService _auth = AuthService();
  //attribute for the form
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  //State
  String email = '';

  @override
  Widget build(BuildContext context) {
    //Check if the email is valid in the format with this regular expression
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Password Lost'),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      left: 30.0, right: 30, top: 20, bottom: 5),
                  child: TextFormField(
                    validator: (value) => value.isEmpty || !emailValid
                        ? "Wrong email format"
                        : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _auth.resetPassword(email);

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
                      }
                    },
                    child: Text(
                      "Change Email",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ])),
        ));
  }
}
