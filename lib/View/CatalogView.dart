import 'package:flutter/material.dart';
import 'package:like_eat/View/SignInView.dart';


class Catalog extends StatefulWidget {
   @override
  _CatalogState createState() => _CatalogState();
}
class _CatalogState extends State<Catalog>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Catalog'),
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
