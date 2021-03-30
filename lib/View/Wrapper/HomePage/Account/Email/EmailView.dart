import 'package:flutter/material.dart';

class EmailChange extends StatefulWidget {
  @override
  _EmailChangeState createState() => _EmailChangeState();
}

class _EmailChangeState extends State<EmailChange> {
  //attribute for the form
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController passwordControllerSecond = TextEditingController();

  //State
  String oldEmail = '';
  String newEmail = '';

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
                      prefixIcon: Icon(Icons.security),
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
                      prefixIcon: Icon(Icons.security),
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //TODO: Change email for the current user

                      } else {}
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
