import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

enum StatusPayment { Error, Done }

class CheckOutManager extends ChangeNotifier {
  CreditCard _selectedCreditCard;
  ShippingAddress _selectedShippingAddress;
  List<CreditCard> _listOfCreditCard;
  List<ShippingAddress> _listOfShippingAddress;
  StatusPayment _statusPayment;
  Map<Product, int> _productsAndQuantity;

  CheckOutManager() {
    //Obtain the data from the managers
    _listOfShippingAddress = ViewModel.addressDataManager.addressS;
    _listOfCreditCard = ViewModel.creditCardManager.creditCards;
    notifyListeners();
  }

  selectCreditCard(int index) {
    _selectedCreditCard = _listOfCreditCard.elementAt(index);
    notifyListeners();
  }

  selectAddress(int index) {
    _selectedShippingAddress = _listOfShippingAddress.elementAt(index);
    notifyListeners();
  }

  performPayment() async {
    bool result = await Webservice().postPayment(_selectedCreditCard.number,
        _selectedCreditCard.cvc, _selectedCreditCard.expDate);

    if (result) {
      _productsAndQuantity = ViewModel.cartManager.allTheCart;
      Webservice().postNewOrder(_productsAndQuantity);
      _statusPayment = StatusPayment.Done;
      notifyListeners();
    } else {
      _statusPayment = StatusPayment.Error;
      notifyListeners();
    }
  }

  get statusPayment => _statusPayment;
}
