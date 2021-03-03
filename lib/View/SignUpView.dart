import 'package:flutter/material.dart';
import 'package:like_eat/View/HomePageView.dart';
import 'package:like_eat/View/SignInView.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  bool _obscureTextFirst = true;
  bool _obscureTextSecond = true;
  bool _privacyTermValue = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControllerFirst = TextEditingController();
  TextEditingController passwordControllerSecond = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/Logo.png',
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
            child: TextField(
              obscureText: _obscureTextFirst,
              controller: passwordControllerFirst,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Password',
                prefixIcon: Icon(Icons.security),
                suffixIcon: InkWell(
                  onTap: _toggle1,
                  child: Icon(
                    _obscureTextFirst
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
            child: TextField(
              obscureText: _obscureTextSecond,
              controller: passwordControllerSecond,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.security),
                suffixIcon: InkWell(
                  onTap: _toggle2,
                  child: Icon(
                    _obscureTextSecond
                        ? Icons.remove_red_eye
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: _privacyTermValue,
                  onChanged: (value) {
                    setState(() {
                      _privacyTermValue = value;
                    });
                  }),
              Container(
                  child: Text(
                      "I agree to the Terms of Services and Privacy Policy."))
            ],
          ),
          Container(
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blueAccent,
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                //check Input provided by the usere: two password the same and if email not already present in db ...
                //check also if agreed on privacy terms if everything ok go on Homepage
                Navigator.pushNamed(context, 'HomePage');
                //if not agreed on privacy term
                //POPUP to agree on check privacy

                //if password not same
                //POP UP with different password

                //if email already present
                //POPUP email already registered
              },
              child: Text(
                "Create account",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Text("Have an account?")),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'SignIn');
                  },
                  child: Text("Sign in"))
            ],
          ),
        ],
      ),
    );
  }

  void _toggle1() {
    setState(() {
      _obscureTextFirst = !_obscureTextFirst;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureTextSecond = !_obscureTextSecond;
    });
  }
}
