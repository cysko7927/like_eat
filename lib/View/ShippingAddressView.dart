import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/AddressDataManager.dart';

class ShippingAddresses extends StatefulWidget {
  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  List shippingAddresses = [];
  TextEditingController state = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController cap = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: Column(children: [
        Row(children: [
          TextField(
            controller: address,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          IconButton(icon: Icon(Icons.add), onPressed: null)
        ]),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: shippingAddresses.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Text(shippingAddresses[index]["Name:"],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                trailing:
                    IconButton(icon: Icon(Icons.delete), onPressed: null));
          },
        ))
      ]),
    );
  }
}
