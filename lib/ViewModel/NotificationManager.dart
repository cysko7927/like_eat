import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class NotificationManager extends ChangeNotifier {
  List<Notifications> _notifications = [];

  Future<void> getNotifications(String nickname) async {
    List<Notifications> result = await Webservice()
        .fetchNotifications(nickname); //Obtain the notifications of a user

    _notifications = result;
    notifyListeners(); //Commit the state to the view
  }

  //Vedere se servono altre operazioni
}
