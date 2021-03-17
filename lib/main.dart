import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_eat/View/Wrapper/HomePage/HomePageView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Settings/SettingView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Catalog/CatalogView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Notification/NotificationView.dart';
import 'package:like_eat/View/Wrapper/HomePage/ObservedProduct/ObservedProductView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Cart/CartView.dart';
import 'package:like_eat/View/Wrapper/HomePage/History/HistoryView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Settings/ShippingAddressView.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:like_eat/View/wrapper.dart';
import 'package:like_eat/ViewModel/AddressDataManager.dart';
=======
import 'package:like_eat/View/Wrapper/wrapper.dart';
>>>>>>> 728a9024d5e90f884090c601372ecf7d7eda455f
import 'package:like_eat/ViewModel/SessionManager.dart';
import 'package:provider/provider.dart';
import 'package:like_eat/Model/User.dart';

import 'Model/ShippingAddress.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error in Firebase',
              textDirection: TextDirection.ltr,
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserAnon>.value(
            //Every time that the state of the user logged changes the widget Wrapper will be rebuilded
            value: AuthService().userAnon, //Check if a user is logged
            child: MaterialApp(
              routes: {
                'HomePage': (context) => HomePage(),
                'Setting': (context) => Setting(),
                'Catalog': (context) => Catalog(),
                'Observed': (context) => ObservedProduct(),
                'Notification': (context) => Notifications(),
                'History': (context) => History(),
                'Cart': (context) => Cart(),
                'Address': (context) =>
                    StreamProvider<List<ShippingAddress>>.value(
                        value: AddressDataManager(
                                FirebaseAuth.instance.currentUser.uid)
                            .address,
                        child: ShippingAddresses())
              },
              home: Wrapper(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: Text(
            'Loading',
            textDirection: TextDirection.ltr,
          ),
        );
      },
    );
  }
}

class TestDB extends StatelessWidget {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document["mail"],
            ),
          ),
          Expanded(
            child: Text(
              document["name"],
            ),
          ),
          Expanded(
            child: Text(
              document["nickname"],
            ),
          ),
          Expanded(
            child: Text(
              document["surname"],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    return Scaffold(
      appBar: AppBar(
        title: Text("Test DB"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading.....");

            return ListView.builder(
              itemCount: snapshot.data.size,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.docs[index]),
            );
          }),
    );
  }
}

class GenericMaterialForTesting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Testing",
      home: TestDB(),
    );
  }
}

class AppTest extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Hello, world!',
              textDirection: TextDirection.ltr,
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GenericMaterialForTesting();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: Text(
            'Hello, world!',
            textDirection: TextDirection.ltr,
          ),
        );
      },
    );
  }
}
