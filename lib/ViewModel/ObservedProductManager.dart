import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

class ObservedProductManager extends ChangeNotifier {
  List<Product> _observedproducts;

  void obtainObservedProduct() async {
    _observedproducts = await Webservice()
        .fetchObservedProducts(ViewModel.userDataManager.user.nickname);
    notifyListeners();
  }

  void insertOrRemoveProduct(String name, String type, String supplier,
      String nickname, bool observed) {
    Webservice().postFlagObservable(name, type, supplier,
        ViewModel.userDataManager.user.nickname, observed);
    obtainObservedProduct();
    notifyListeners();
  }
}
