import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/ObservedProduct/ObservedList.dart';

class ObservedProduct extends StatefulWidget {
  @override
  _ObservedProductState createState() => _ObservedProductState();
}

class _ObservedProductState extends State<ObservedProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        key: ValueKey("Observed_appBarKey"),
        title: Text('Observed Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(child: SizedBox(height: 400.0, child: ObservedList())),
            ],
          ),
        ),
      ),
    );
  }
}
