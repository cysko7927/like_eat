import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/ViewModel/CreditCardManager.dart';
import 'package:provider/provider.dart';

class CreditCardList extends StatefulWidget {
  @override
  _CreditCardListState createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {
  @override
  Widget build(BuildContext context) {
    final List<CreditCard> creditCard = Provider.of<List<CreditCard>>(context);

    if (creditCard != null) {
      return ListView.builder(
          itemCount: creditCard.length,
          itemBuilder: (context, index) {
            return CreditCardTile(creditCard.elementAt(index),index);
          });
    } else {
      return ListView.builder(
          itemCount: new List<CreditCard>().length,
          itemBuilder: (context, index) {
            return CreditCardTile(creditCard[index],index);
          });
    }
  }
}

class CreditCardTile extends StatelessWidget {
  final CreditCard creditCard;
final int index;
  CreditCardManager creditCardManager=CreditCardManager(FirebaseAuth.instance.currentUser.uid);

  CreditCardTile(this.creditCard,this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(creditCard.number),
              subtitle: Text(creditCard.cvc + " " + creditCard.expDate),
              trailing: Wrap(
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      creditCardManager.deleteCreditCard(creditCard);
                    })
              ],
            ),),
        ));
  }
}
