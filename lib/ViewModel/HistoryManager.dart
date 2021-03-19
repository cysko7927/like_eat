import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class HistoryManager extends ChangeNotifier {
  final String uidUser; //UID of the user whose orders you want

  CollectionReference orderReference =
      FirebaseFirestore.instance.collection('Order');
List<Order> _listOfOrder = [];

  HistoryManager(this.uidUser);

  void obtainOrder() async {
    QuerySnapshot result =
        await orderReference.where('uidUser', isEqualTo: uidUser).get();

    _listOfOrder = _ordersListFromSnapshot(result);
  }
  //obtain the stream of the list of the orders of the user with uid = uidUser from this class
  Stream<List<Order>> get obtainHistory {
    obtainOrder();
    return orderReference
        .where('uidUser', isEqualTo: uidUser)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  //Convert The querySnapshot that contains the orders in a list
  //that contains those orders
  //Precondition: The snapshot must contain the orders with the correct parameters
  List<Order> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Order(
              doc.data()['time'] ?? '',
              doc.data()['productAndQuantity'] ?? new Map(),
            ))
        .toList();
  }
}
