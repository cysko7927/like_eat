import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';

import 'package:like_eat/main.dart';

void main() {
  runApp(AppTest());

  AuthService auth = new AuthService();
  dynamic user = auth.signInAnom();

  if (user == null) {
    print("Error");
  } else {
    print("signed-in");
    print(user);
  }
}
