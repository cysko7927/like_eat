import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{
  @override
  _State createState() => _State();
}
class _State extends State<SignIn>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/Logo.png'),
            Container(child: Text("Sign In")),
            Container(child: Text("Welcome Back")),
            Container(child: Text("Email")),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            Container(child: Text("Password")),
            TextField(
              obscureText: _obscureText,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: InkWell(
                    onTap: _toggle,
                    child: Icon(
                      _obscureText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off,
                      size: 15.0,
                      color: Colors.black,
                    ),
                  ),
              ),
            ),
            Container(
              child: FlatButton(
                      color: Colors.red[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.redAccent,
                      onPressed: () {
                        //For now it just print the email and password on the terminal
                        print(emailController.text);
                        print(passwordController.text);
                      },
                      child: Text("Sign In",style: TextStyle(fontSize: 20.0),
                      ),
                    ),
            ),
            Container(child: Text("Or use one of your social profiles")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {},
                      child: Text("Twitter",style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ),
                Container(
                  child: FlatButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {},
                      child: Text("Facebook",style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                      color: Colors.transparent,
                      textColor: Colors.black,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {},
                      child: Text("Forgot password?",style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                FlatButton(
                      color: Colors.red[200],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.redAccent,
                      onPressed: () {},
                      child: Text("Sign Up",style: TextStyle(fontSize: 20.0),
                      ),
                    )
              ],
            )
          ],
        ),
      ),
    );
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}


