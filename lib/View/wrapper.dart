import 'package:flutter/material.dart';
import 'package:like_eat/View/HomePageView.dart';
import 'package:provider/provider.dart';
import 'package:like_eat/Model/User.dart';
import 'package:like_eat/View/Authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAnon>(
        context); //Obtain the state of the user logged from the provider

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
