import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/History/HistoryList.dart';
import 'package:like_eat/ViewModel/HistoryManager.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  HistoryManager historyManager =
      HistoryManager(FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        key: ValueKey("History_appBarKey"),
        title: Text('History'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(child: SizedBox(height: 800.0, child: HistoryList())),
            ],
          ),
        ),
      ),
    );
  }
}
