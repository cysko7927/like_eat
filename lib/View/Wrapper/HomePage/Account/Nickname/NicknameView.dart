import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';

class NicknameChange extends StatefulWidget {
  @override
  _NicknameChangeState createState() => _NicknameChangeState();
}

class _NicknameChangeState extends State<NicknameChange> {
  //attribute for the form
  final _formKey = GlobalKey<FormState>();
  TextEditingController newNicknameController = TextEditingController();
  ModifyNickname modifyNickname =
      new ModifyNickname(FirebaseAuth.instance.currentUser.uid);
  //State
  String newNickname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Change Nickname'),
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
                    validator: (value) =>
                        value.isEmpty ? "Insert a non null nickname" : null,
                    onChanged: (val) {
                      setState(() => newNickname = val);
                    },
                    controller: newNicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your new nickname',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //TODO: Change nickname for the current user
                        modifyNickname.modifyNickname(newNickname);

                        Widget okButton = FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );

                        // Create AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Nickname modified"),
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
                      } else {}
                    },
                    child: Text(
                      "Change Nickname",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ])),
        ));
  }
}
