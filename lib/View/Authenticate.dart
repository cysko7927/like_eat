import 'package:flutter/material.dart';
import 'package:like_eat/View/SignInView.dart';
import 'package:like_eat/View/SignUpView.dart';

class Authenticate extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}
