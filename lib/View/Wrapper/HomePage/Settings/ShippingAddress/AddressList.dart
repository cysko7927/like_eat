import 'package:flutter/material.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/View/Wrapper/HomePage/Settings/ShippingAddress/AddressTile.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    final address = Provider.of<List<ShippingAddress>>(context);

    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (context, index) {
          return AddressTile(address[index]);
        });
  }
}
