import 'package:flutter/material.dart';


class Notifications extends StatefulWidget {
   @override
  _NotificationState createState() => _NotificationState();
}
class _NotificationState extends State<Notifications>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Notification'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: null
          )
        ],
      ),
      body: SingleChildScrollView(
        
      ), 
    );
  }
}
