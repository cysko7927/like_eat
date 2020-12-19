import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
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
            TextField(),
            Container(child: Text("Password")),
            TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark),
                    onPressed: null),
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
                      onPressed: () {},
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
}
