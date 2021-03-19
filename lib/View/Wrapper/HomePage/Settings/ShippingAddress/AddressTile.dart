import 'package:flutter/material.dart';
import 'package:like_eat/Model/ShippingAddress.dart';

class AddressTile extends StatelessWidget {
  final ShippingAddress address;

  AddressTile(this.address);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              title: Text(address.address),
              subtitle: Text(address.number +
                  " " +
                  address.city +
                  " " +
                  address.cap +
                  " " +
                  address.state)),
        ));
  }
}
