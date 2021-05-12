import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/Notification/NotificationList.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                  child: SizedBox(height: 400.0, child: NotificationList())),
            ],
          ),
        ),
      ),
    );
  }
}
