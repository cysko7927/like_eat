import 'package:flutter/material.dart';
import 'package:like_eat/View/SignInView.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        margin: const EdgeInsets.only(
                  left: 5.0),
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
                Row(
                  children: [
                    Icon(Icons.language),
                    FlatButton(onPressed: null, child: Text("Language"))
                  ],
                ),
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
          Row(
            children: [
              Icon(Icons.security),
              FlatButton(onPressed: null, child: Text("Change Password"))
            ],
          ),
          Row(
            children: [
              Icon(Icons.email),
              FlatButton(onPressed: null, child: Text("Change email"))
            ],
          ),
          Row(
            children: [
              Icon(Icons.account_circle),
              FlatButton(onPressed: null, child: Text("Change Profile Picture"))
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: 
                  Colors.grey[800].withOpacity(0.5),
              ),
            
            alignment: Alignment.topLeft,
            child: Text(
              "Others",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),
          Row(
            children: [
              Icon(Icons.security),
              FlatButton(onPressed: null, child: Text("Other option"))
            ],
          ),
          Row(
            children: [
              Icon(Icons.email),
              FlatButton(onPressed: null, child: Text("Other option"))
            ],
          ),
          Row(
            children: [
              Icon(Icons.account_circle),
              FlatButton(onPressed: null, child: Text("Other option"))
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: 
                  Colors.grey[800].withOpacity(0.5),
              ),
            
            alignment: Alignment.topLeft,
            child: Text(
              "Log Out",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),
          Row(
            children: [
                  Icon(Icons.exit_to_app),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'SignIn');
                      },
                      child: Text("Logout"))
                ],
          ),
        ]),
      ),
    );
  }
}
