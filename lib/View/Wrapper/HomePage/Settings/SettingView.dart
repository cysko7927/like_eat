import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool userIsOut = false;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // built the setting widget
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(children: [
          Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Common",
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                  ),
                ),
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
                    Icon(Icons.language),
                    Text(
                      "Language",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
                Row(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Account",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),
        
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
                onPressed: null,
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
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Others",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),
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
                    Icon(Icons.location_on),
                    Text(
                      "Other option",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )),
          
         
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Log Out",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: FlatButton(
                textColor: Colors.white,
                onPressed: () async {
                    //The user has tapped the logout button
                    await _auth
                        .signOut(); //Ask to the Authenticatio widget to logout the user

                    Navigator.pop(context); //Close the setting widget
                  },
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text(
                      "Logout",
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
