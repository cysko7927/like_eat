import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/Authenticate/VerificationEmailView.dart';
import 'package:like_eat/View/Wrapper/HomePage/HomePageView.dart';
import 'package:provider/provider.dart';
import 'package:like_eat/Model/User.dart';
import 'package:like_eat/View/Wrapper/Authenticate/Authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAnon>(
        context); //Obtain the state of the user logged from the provider

    if (user == null) {
      return Authenticate();
    } else {
      User user = FirebaseAuth.instance.currentUser;

      user.reload();
      if (!user.emailVerified) {
        return VerificationEmail(user.email);
      } else {
        return HomePage();
      }
    }
  }
}
