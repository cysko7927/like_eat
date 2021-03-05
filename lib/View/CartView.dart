import 'package:flutter/material.dart';


class Cart extends StatefulWidget {
   @override
  _CartState createState() => _CartState();
}
class _CartState extends State<Cart>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'Setting');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        
      ), 
    );
  }
}
