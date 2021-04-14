import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Discount.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/StockUpdate.dart';

class NotificationManager extends ChangeNotifier {
  final String uidUser;
  CollectionReference notificationsReference =
      FirebaseFirestore.instance.collection('Notification');
  List<Notifications> _notifications = [];

  NotificationManager(this.uidUser);

/*
  Future<void> getNotifications(String nickname) async {
    List<Notifications> result = await Webservice()
        .fetchNotifications(nickname); //Obtain the notifications of a user

    _notifications = result;
    notifyListeners(); //Commit the state to the view
  }
*/
  //Vedere se servono altre operazioni
  //

  List<Notifications> _notificationsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => doc.data()['typeNotification'] == 'StockUpdate'
            ? StockUpdate(
                Product(doc.data()['supplierProduct'],
                    doc.data()['typeProduct'], doc.data()['nameProduct'], 0, 0),
                doc.data()['message'])
            : Discount(
                Product(doc.data()['supplierProduct'],
                    doc.data()['typeProduct'], doc.data()['nameProduct'], 0, 0),
                doc.data()['message']))
        .toList();
  }

  /**
   * Remove a Shipping Address from the DB using the index in input
   * Precondition: the selected address must be exist in the DB
   */
  void removeNotification(
      Notifications notification, String typeNotification) async {
    //obtain the reference to the address to remove
    QuerySnapshot result = await notificationsReference
        .where('uid', isEqualTo: uidUser)
        .where('typeProduct', isEqualTo: notification.referenceProduct.type)
        .where('supplierProduct',
            isEqualTo: notification.referenceProduct.supplier)
        .where('nameProduct', isEqualTo: notification.referenceProduct.name)
        .where('message', isEqualTo: notification.message)
        .where('typeNotification', isEqualTo: typeNotification)
        .get(); //obtain the reference of the selected address from DB

    notificationsReference
        .doc(result.docs.elementAt(0).id)
        .delete(); //Remove the selected Address to DB
  }

  //obtain the stream of the list of Notifications of the user with uid = uidUser from this class
  Stream<List<Notifications>> get notificationsStream {
    return notificationsReference
        .where('uid', isEqualTo: uidUser)
        .snapshots()
        .map(_notificationsListFromSnapshot);
  }
}
