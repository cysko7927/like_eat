import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/Model/ShippingAddress.dart';
import 'package:like_eat/ViewModel/AddressDataManager.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    final List<ShippingAddress> address =
        Provider.of<List<ShippingAddress>>(context);

    if (address != null) {
      return ListView.builder(
          itemCount: address.length,
          itemBuilder: (context, index) {
            return AddressTile(address.elementAt(index), index);
          });
    } else {
      return ListView.builder(
          itemCount: new List<ShippingAddress>().length,
          itemBuilder: (context, index) {
            return AddressTile(address[index], index);
          });
    }
  }
}

class AddressTile extends StatelessWidget {
  final ShippingAddress address;
  final int index;
  AddressDataManager addressDataManager =
      AddressDataManager(FirebaseAuth.instance.currentUser.uid);
  AddressTile(this.address, this.index);

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
                address.state),
            trailing: Wrap(
              children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      addressDataManager.removeShippingAddress(address);
                    })
              ],
            ),
          ),
        ));
  }
}
