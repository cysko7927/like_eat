import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  List shippingAddresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: Column(
        children: [
        Row(
          children: [
          TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: null,
          )
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
