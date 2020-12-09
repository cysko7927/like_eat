import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

/**
 * This class allows to handle the Credit Cards of the user
 * and  store them for the view
 * The single Credit Card is immutable
 */
class CreditCardManager extends ChangeNotifier {
  List<CreditCard> _listOfCreditCards = [];

  void obtainCreditCards() async {
    _listOfCreditCards = await Webservice()
        .fetchCreditCards(ViewModel.userDataManager.user.nickname);

    notifyListeners();
  }

  void addCreditCard(String number, String cvc, String expDate) {
    Webservice().postAddCreditCard(
        //Add the new Credit Card
        number,
        cvc,
        expDate,
        ViewModel.userDataManager.user.nickname);
    obtainCreditCards(); //Update the state
    notifyListeners(); //Notify the view
  }

  void deleteCreditCard(int index) {
    CreditCard selected = _listOfCreditCards.elementAt(index);

    Webservice().postRemoveCreditCard(
        selected.number,
        selected.cvc,
        selected.expDate,
        ViewModel
            .userDataManager.user.nickname); //Remove the selected Credit Card

    obtainCreditCards(); //Update the state
    notifyListeners(); //Notify the view
  }
}
