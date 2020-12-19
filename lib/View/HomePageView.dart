import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Home Page'),
          ),
          body: Column(
            children: [
              Image.asset('assets/images/Matteo.png'),
              Container(child: Text("matteo.cecini@mail.polimi.it")),
              Row(
                children: [
                  Icon(Icons.home),
                  FlatButton(onPressed: null, child: Text("Home"))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.list),
                  FlatButton(onPressed: null, child: Text("Catalog"))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.favorite),
                  FlatButton(onPressed: null, child: Text("Observed Product"))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.notifications),
                  FlatButton(onPressed: null, child: Text("Notification"))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.settings),
                  FlatButton(onPressed: null, child: Text("Settings"))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.exit_to_app),
                  FlatButton(onPressed: null, child: Text("Logout"))
                ],
              )
            ],
          )),
    );
  }
}
