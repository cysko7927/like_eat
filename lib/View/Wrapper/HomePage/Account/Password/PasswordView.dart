import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_eat/Model/User.dart';
import 'package:provider/provider.dart';

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  // user ModifyPassword to modify the password in firestore
  ModifyPassword modifyPassword =
      new ModifyPassword(FirebaseAuth.instance.currentUser.uid);
  //attribute for the form
  final _formKey = GlobalKey<FormState>();
  String rightOldPassword;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordControllerFirst = TextEditingController();
  TextEditingController passwordControllerSecond = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _obscureTextFirst = true;
  bool _obscureTextSecond = true;
  bool _obscureTextOld = true;

  //State
  String oldPassword = '';
  String password1 = '';
  String password2 = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    final userApp = Provider.of<UserApp>(context);
    //Check if the passwords are equal
    bool passwordsEqual = password1 == password2;

    //Check if the email is valid in the format with this regular expression
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Change Password'),
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
                    validator: (value) => value.isEmpty ||
                            !emailValid //|| Check if old email is the same
                        ? "Wrong email"
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
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty || value.compareTo(userApp.password) != 0
                            ? "Wrong old password"
                            : null,
                    onChanged: (val) {
                      setState(() => oldPassword = val);
                    },
                    obscureText: _obscureTextOld,
                    controller: oldPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your old password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggleOld,
                        child: Icon(
                          _obscureTextOld
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) => value.length < 8
                        ? "Enter a new Password greater at least 8 characters"
                        : null, //The password must be greater of 8
                    onChanged: (val) {
                      setState(() => password1 = val);
                    },
                    obscureText: _obscureTextFirst,
                    controller: passwordControllerFirst,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a new Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggle1,
                        child: Icon(
                          _obscureTextFirst
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) => value.isEmpty || !passwordsEqual
                        ? "The passwords must be equal"
                        : null, //The two passowrd inserted by user in the form must be equal
                    onChanged: (val) {
                      setState(() => password2 = val);
                    },
                    obscureText: _obscureTextSecond,
                    controller: passwordControllerSecond,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm the new Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggle2,
                        child: Icon(
                          _obscureTextSecond
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
                        //TODO
                        //modify the password stored with the new one
                        StatusModify status = await modifyPassword
                            .modifyPassword(email, oldPassword, password1);

                        Widget okButton = FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        if (obtainStringError(status) == "Okay") {
                          // Create AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Password modified"),
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
                          Widget okButton = FlatButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );

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
                      "Change Password",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ])),
        ));
  }

  void _toggle1() {
    setState(() {
      _obscureTextFirst = !_obscureTextFirst;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureTextSecond = !_obscureTextSecond;
    });
  }

  void _toggleOld() {
    setState(() {
      _obscureTextOld = !_obscureTextOld;
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
