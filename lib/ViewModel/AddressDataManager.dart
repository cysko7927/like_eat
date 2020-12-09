import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

/**
 * This class allows to handle the Shipping Address of the user
 * and  store them for the view
 * The single Shipping Address is immutable
 */
class AddressDataManager extends ChangeNotifier {
  List<ShippingAddress> _listOfShippingAddress = [];

  void obtainShippingAddress() async {
    _listOfShippingAddress = await Webservice()
        .fetchShippingAddress(ViewModel.userDataManager.user.nickname);
    notifyListeners();
  }

  void addShippingAddress(
      String state, String address, String city, int cap, int number) async {
    Webservice().postAddShippingAddress(
        //Add the new Shipping Address
        state,
        address,
        city,
        cap,
        number,
        ViewModel.userDataManager.user.nickname);

    obtainShippingAddress(); //Update the state
    notifyListeners(); //Notify the view
  }

  void removeShippingAddress(int index) async {
    ShippingAddress selected = _listOfShippingAddress.elementAt(index);

    Webservice().postRemoveShippingAddress(
        //Remove the selected Shipping Address
        selected.state,
        selected.address,
        selected.city,
        selected.cap,
        selected.number,
        ViewModel.userDataManager.user.nickname);

    obtainShippingAddress(); //Update the state
    notifyListeners(); //Notify the view
  }
}
