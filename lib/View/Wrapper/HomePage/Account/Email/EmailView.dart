import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';

class EmailChange extends StatefulWidget {
  @override
  _EmailChangeState createState() => _EmailChangeState();
}

class _EmailChangeState extends State<EmailChange> {
  // user ModifyEmail to modify the email in firestore
  ModifyEmail modifyEmail =
      new ModifyEmail(FirebaseAuth.instance.currentUser.uid);
  //attribute for the form
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //State
  String password = '';
  String oldEmail = '';
  String newEmail = '';

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    //Check if the email is valid in the format with this regular expression
    bool oldEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(oldEmail);
    bool newEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(newEmail);
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Change Email'),
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
                    validator: (value) => value.isEmpty || !oldEmailValid
                        ? "Wrong old email"
                        : null,
                    onChanged: (val) {
                      setState(() => oldEmail = val);
                    },
                    controller: oldEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your old email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) => value.isEmpty || !newEmailValid
                        ? "Enter a valid new email"
                        : null,
                    onChanged: (val) {
                      setState(() => newEmail = val);
                    },
                    controller: newEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a new email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? "Wrong Password" : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: _obscureText,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                      ),
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
                        StatusModify status = await modifyEmail.modifyEmail(
                            oldEmail, password, newEmail);

                        Widget okButton = FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        if (obtainStringError(status) == "Okay") {
                          // Create AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Email modified"),
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
                            title: Text(obtainStringError(status)),
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
                      "Change Email",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ])),
        ));
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String obtainStringError(StatusModify status) {
    switch (status) {
      case StatusModify.PasswordWeak:
        return "Password is weak try a new password more long";
      case StatusModify.UserMismatch:
        return "The credentials of the user are mismatched";
      case StatusModify.UserNotFound:
        return "The user with this email doesn't exist";
      case StatusModify.InvalidCredentials:
        return "The credentials are invalid";
      case StatusModify.InvalidEmail:
        return "The email is wrong";
      case StatusModify.WrongPassword:
        return "The old Password is wrong";
      case StatusModify.Error:
        return "Error of connection";
      case StatusModify.EmailAlreadyUsed:
        return "The email inserted is already used";
      case StatusModify.Okay:
        return "Okay";
    }
  }
}
