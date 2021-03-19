import 'package:flutter/material.dart';

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
          color: Colors.lightBlue[100],
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    border: Border.all(
                      color: Colors.blue[300],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ClipOval(
                  child: Image.asset('assets/images/Matteo.png'),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(
                        color: Colors.blue[300],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Cart');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          "Cart",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(
                        color: Colors.blue[300],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'History');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          "History",
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(
                        color: Colors.blue[300],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Catalog');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list,
                          color: Colors.white,
                          size: 50,
                        ),
                        Text(
                          "Catalog",
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    border: Border.all(
                      color: Colors.blue[300],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                    child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Observed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        "Observed\nProduct",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                )),
              ),
              Container(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        border: Border.all(
                          color: Colors.blue[300],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Notification');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            "Notification",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
