import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Column(
          children: [
            Container(child: Text("Sign Up")),
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
            Container(child: Text("Confirm Password")),
            TextField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark),
                    onPressed: null),
              ),
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: null),
                Container(child: Text("I agree to the Terms of Services and Privacy Policy.")
                )
              ],
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
                      child: Text("Create account",style: TextStyle(fontSize: 20.0),
                      ),
                    ),
            ),
            Row(
              children: [
                Container(child: Text("Have an account?")),
                FlatButton(onPressed: null, child: Text("Sign in"))
                ],
            ),
          ],
        ),
      ),
    );
  }
}
