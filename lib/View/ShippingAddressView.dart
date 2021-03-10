import 'package:flutter/material.dart';

class ShippingAddresses extends StatefulWidget {
  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  List shippingAddresses = [];
  final _formKey = GlobalKey<FormState>();
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        child: Text("Add new Address",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.blue))),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          controller: state,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your State')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          controller: address,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your address')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          controller: city,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your city')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          controller: cap,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your cap')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          controller: number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your number')),
                    ),
                  ],
                )),
            Column(children: [
              Container(
                  child: Text("List Address",
                      style: TextStyle(fontSize: 20.0, color: Colors.blue))),
              Row(
                children: [
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: Text("state, ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black))),
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: Text("address, ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black))),
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: Text("city, ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black))),
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: Text("cap, ",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black))),
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: Text("number",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black))),
                  Container(
                      margin:
                          EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                      child: IconButton(icon: Icon(Icons.delete),
                      onPressed: null))
                ],
              )
            ])
          ],
        )));
  }
}
