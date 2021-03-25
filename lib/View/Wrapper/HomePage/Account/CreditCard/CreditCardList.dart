import 'package:flutter/material.dart';
import 'package:like_eat/Model/CreditCard.dart';
import 'package:provider/provider.dart';

class CreditCardList extends StatefulWidget {
  @override
  _CreditCardListState createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {
  @override
  Widget build(BuildContext context) {
    final creditCard = Provider.of<List<CreditCard>>(context);

    if (creditCard != null) {
      return ListView.builder(
          itemCount: creditCard.length,
          itemBuilder: (context, index) {
            return CreditCardTile(creditCard[index]);
          });
    } else {
      return ListView.builder(
          itemCount: new List<CreditCard>().length,
          itemBuilder: (context, index) {
            return CreditCardTile(creditCard[index]);
          });
    }
  }
}

class CreditCardTile extends StatelessWidget {
  final CreditCard creditCard;

  CreditCardTile(this.creditCard);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(creditCard.number),
              subtitle: Text(creditCard.cvc + " " + creditCard.expDate)),
        ));
  }
}
