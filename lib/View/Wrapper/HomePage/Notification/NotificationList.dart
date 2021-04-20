import 'package:flutter/material.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:like_eat/ViewModel/NotificationManager.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    final List<Notifications> notification =
        Provider.of<List<Notifications>>(context);

    if (notification != null) {
      return ListView.builder(
          itemCount: notification.length,
          itemBuilder: (context, index) {
            return NotificationTile(notification[index]);
          });
    } else {
      return ListView.builder(
          itemCount: new List<Notifications>().length,
          itemBuilder: (context, index) {
            return NotificationTile(notification[index]);
          });
    }
  }
}

class NotificationTile extends StatelessWidget {
  final Notifications notification;
  NotificationManager notificationManager =
      NotificationManager(FirebaseAuth.instance.currentUser.uid);
  NotificationTile(this.notification);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              title: Text(notification.message.toString()),
              subtitle: Text("Product observed: " +
                  notification.referenceProduct.name +
                  "\nMessage type: " +
                  notification.runtimeType.toString()),
              trailing: Wrap(
                children: [
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        notificationManager.removeNotification(
                            notification, notification.runtimeType.toString());
                      })
                ],
              ),
            )));
  }
}
