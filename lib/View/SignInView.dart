import 'package:flutter/material.dart';
import 'package:like_eat/View/HomePageView.dart';
import 'package:like_eat/View/SignUpView.dart';

class SignIn extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              obscureText: _obscureText,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your Password',
                prefixIcon: Icon(Icons.security),
                suffixIcon: InkWell(
                  onTap: _toggle,
                  child: Icon(
                    _obscureText ? Icons.remove_red_eye : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: FlatButton(
              color: Colors.blue[400],
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                //For now it just print the email and password on the terminal
                print(emailController.text);
                print(passwordController.text);

                //we need to check if credential are correct in the database and if there are we go to the homepage
                Navigator.pushNamed(context, 'HomePage');

                //otherwise we remain here popping a pop up that says: wrong credential
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Container(child: Text("Or use one of your social profiles")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    onPressed: () {},
                    child: Text(
                      "Twitter",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    onPressed: () {},
                    child: Text(
                      "Facebook",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.red[200],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.redAccent,
                  onPressed: () {},
                  child: Text(
                    "Forgot password",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                  child: FlatButton(
                color: Colors.red[200],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.redAccent,
                onPressed: () {
                  Navigator.pushNamed(context, 'SignUp');
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20.0),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
