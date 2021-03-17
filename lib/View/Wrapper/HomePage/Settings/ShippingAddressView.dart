import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/Settings/AddressList.dart';
import 'package:like_eat/ViewModel/AddressDataManager.dart';

class ShippingAddresses extends StatefulWidget {
  @override
  _ShippingAddressesState createState() => _ShippingAddressesState();
}

class _ShippingAddressesState extends State<ShippingAddresses> {
  List shippingAddresses = [];
  //State variables
  String address = '';
  String state = '';
  String city = '';
  String cap = '';
  String number = '';
  final _formKey = GlobalKey<FormState>();
  //Controllers
  TextEditingController stateController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController capController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  //Manager of View-Model
  AddressDataManager addressDataManager =
      AddressDataManager(FirebaseAuth.instance.currentUser.uid);

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
                          validator: (value) =>
                              value.isEmpty ? "Enter a state" : null,
                          onChanged: (val) {
                            setState(() => state = val);
                          },
                          controller: stateController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your State')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter an address" : null,
                          onChanged: (val) {
                            setState(() => address = val);
                          },
                          controller: addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your address')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter a city" : null,
                          onChanged: (val) {
                            setState(() => city = val);
                          },
                          controller: cityController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your city')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter a CAP" : null,
                          onChanged: (val) {
                            setState(() => cap = val);
                          },
                          controller: capController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your CAP')),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30.0, right: 30, top: 5, bottom: 5),
                      child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter a phone number" : null,
                          onChanged: (val) {
                            setState(() => number = val);
                          },
                          controller: numberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your phone number')),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(),
                        ),
                        child: FlatButton(
                          textColor: Colors.white,
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                addressDataManager.addShippingAddress(
                                    state, address, city, cap, number)
                              }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Insert new address",
                                style: TextStyle(fontSize: 15.0),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            Row(
              children: [
                Expanded(child: SizedBox(height: 200.0, child: AddressList())),
              ],
            ),
          ],
        )));
  }
}
