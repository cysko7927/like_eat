import 'package:flutter/material.dart';


class History extends StatefulWidget {
   @override
  _HistoryState createState() => _HistoryState();
}
class _HistoryState extends State<History>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('History'),
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
