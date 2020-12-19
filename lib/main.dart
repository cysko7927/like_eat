import 'package:flutter/material.dart';
import 'package:like_eat/View/HomePageView.dart';
import 'package:like_eat/View/SignInView.dart';
import 'package:like_eat/View/SignUpView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'like it',
      initialRoute: 'SignIn',
      routes: {
        'SignIn': (context) => SignIn(),
        'HomePage': (context) => HomePage(),
        'SignUp': (context) => SignUp()
      },
    );
  }
}
