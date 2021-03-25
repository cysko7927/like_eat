import 'package:flutter/material.dart';



class ObservedProduct extends StatefulWidget {
   @override
  _ObservedProductState createState() => _ObservedProductState();
}
class _ObservedProductState extends State<ObservedProduct>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Observed Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        
      ), 
    );
  }
}
