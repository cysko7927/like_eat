import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/History/HistoryList.dart';
import 'package:like_eat/ViewModel/HistoryManager.dart';


class History extends StatefulWidget {
   @override
  _HistoryState createState() => _HistoryState();
}
class _HistoryState extends State<History>{
  HistoryManager historyManager =
      HistoryManager(FirebaseAuth.instance.currentUser.uid);

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
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Expanded(child: SizedBox(height: 200.0, child: HistoryList())),
      ), 
    );
  }
}
