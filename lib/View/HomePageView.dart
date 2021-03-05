import 'package:flutter/material.dart';
import 'package:like_eat/View/SignInView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'History');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.history),
                      Text(
                        "History",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                )),
                Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Cart');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      Text(
                        "Cart",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Catalog');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.list),
                      Text(
                        "Catalog",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Observed');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.favorite),
                      Text(
                        "Observed Product",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 5, bottom: 5),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                ),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                   onPressed: () {
                    Navigator.pushNamed(context, 'Notification');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.notifications),
                      Text(
                        "Notification",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
