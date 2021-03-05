import 'package:flutter/material.dart';
import 'package:like_eat/View/SignInView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'Setting');
            },
          )
        ],
      ),
      body: Container(
        color: Colors.blue[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(30.0),
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              height: 50,
              child: ClipOval(
                child: Image.asset('assets/images/Matteo.png'),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'SignUp');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      Text(
                        "Home",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 5, bottom: 5),
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Icon(Icons.home),
                  FlatButton(onPressed: null, child: Text("Home"))
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    Icon(Icons.list),
                    FlatButton(onPressed: null, child: Text("Catalog"))
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 5, bottom: 5),
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Icon(Icons.favorite),
                  FlatButton(onPressed: null, child: Text("Observed Product"))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 5, bottom: 5),
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications),
                  FlatButton(onPressed: null, child: Text("Notification"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
