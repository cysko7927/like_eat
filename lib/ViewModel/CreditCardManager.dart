import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String uidUser; //UID of the user whose addresses you want
  CollectionReference creditCardsReference =
      FirebaseFirestore.instance.collection('CreditCard'); //Reference to DB
  List<CreditCard> _listOfCreditCards = [];

  CreditCardManager(this.uidUser);

  /**
   * Obtain the list of Credit Card from the DB and save it inside the object
   */
  void obtainCreditCards() async {
    QuerySnapshot result =
        await creditCardsReference.where('uidUser', isEqualTo: uidUser).get();

    _listOfCreditCards = _creditCardListFromSnapshot(result);
  }

  //Add a new Credit Card in the DB for the user
  void addCreditCard(String number, String cvc, String expDate) {
    //Add the new CreditCard in the DB
    creditCardsReference.add({
      'number': number,
      'cvc': cvc,
      'expDate': expDate,
      'uidUser': uidUser,
    });

    obtainCreditCards(); //Update the state
  }

  /**
   * Remove a Credit Card from the DB using the index in input
   * Precondition: the selected Credit Card must be exist in the DB
   */
  void deleteCreditCard(int index) async {
    CreditCard selected = _listOfCreditCards
        .elementAt(index); //Take the credit card from the local list

    //obtain the reference to the credit cards to remove
    QuerySnapshot result = await creditCardsReference
        .where('uidUser', isEqualTo: uidUser)
        .where('number', isEqualTo: selected.number)
        .where('cvc', isEqualTo: selected.cvc)
        .where('expDate', isEqualTo: selected.expDate)
        .get(); //obtain the reference of the selected credits cards from DB

    creditCardsReference
        .doc(result.docs.elementAt(0).id)
        .delete(); //Remove the selected credit cards to DB

    obtainCreditCards(); //Update the list of the credit cards inside the object
  }

  //obtain the stream of the list of credit cards of the user with uid = uidUser from this class
  Stream<List<CreditCard>> get creditCardsStream {
    obtainCreditCards(); //Update the list of credit Cards inside the object
    return creditCardsReference
        .where('uidUser', isEqualTo: uidUser)
        .snapshots()
        .map(_creditCardListFromSnapshot);
  }

  //Convert The querySnapshot that contains the credit Cards in a list
  //that contains those Credit cards
  //Precondition: The snapshot must contain the credit cards with the correct parameters
  List<CreditCard> _creditCardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => CreditCard(
              doc.data()['number'] ?? '',
              doc.data()['cvc'] ?? '',
              doc.data()['expDate'] ?? '',
            ))
        .toList();
  }

  get creditCards => _listOfCreditCards;
}
