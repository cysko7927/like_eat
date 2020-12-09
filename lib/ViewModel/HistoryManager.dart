import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class HistoryManager extends ChangeNotifier {
  List<Order> _historyOrder;

  void obtainHistory(String nickname) async {
    List<Order> result = await Webservice().fetchHistory(nickname);

    _historyOrder = result;
    notifyListeners();
  }
}
