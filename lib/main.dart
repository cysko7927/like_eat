import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

//Model Import
import 'package:like_eat/Model/CreditCard.dart';
import 'package:like_eat/Model/Order.dart';
import 'package:like_eat/Model/Product.dart';
import 'package:like_eat/Model/Notification.dart';
import 'package:like_eat/Model/User.dart';
import 'package:like_eat/Model/ShippingAddress.dart';

//Import View
//Import for Account
import 'package:like_eat/View/Wrapper/HomePage/Account/AccountView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/Password/PasswordView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/ShippingAddress/ShippingAddressView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/CreditCard/CreditCardView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/Email/EmailView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Account/Nickname/NicknameView.dart';

import 'package:like_eat/View/Wrapper/wrapper.dart';
import 'package:like_eat/View/Wrapper/Authenticate/LostPasswordView.dart';

import 'package:like_eat/View/Wrapper/HomePage/Catalog/CatalogView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Notification/NotificationView.dart';
import 'package:like_eat/View/Wrapper/HomePage/ObservedProduct/ObservedProductView.dart';
import 'package:like_eat/View/Wrapper/HomePage/Cart/CartView.dart';
import 'package:like_eat/View/Wrapper/HomePage/History/HistoryView.dart';
import 'package:like_eat/View/Wrapper/HomePage/HomePageView.dart';
import 'package:like_eat/View/Wrapper/HomePage/CheckOutView.dart';

//Import ViewModel
import 'package:like_eat/ViewModel/CartManager.dart';
import 'package:like_eat/ViewModel/CreditCardManager.dart';
import 'package:like_eat/ViewModel/HistoryManager.dart';
import 'package:like_eat/ViewModel/ObservedProductManager.dart';
import 'package:like_eat/ViewModel/UserDataManager.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';
import 'package:like_eat/ViewModel/AddressDataManager.dart';
import 'package:like_eat/ViewModel/NotificationManager.dart';

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
                'LostPassword': (context) => LostPassword(),
                'HomePage': (context) => HomePage(),

                'Catalog': (context) => Catalog(),
                'Observed': (context) => StreamProvider<List<Product>>.value(
                    value: ObservedProductManager(
                            FirebaseAuth.instance.currentUser.uid)
                        .productsObserved,
                    child: ObservedProduct()),
                'Notification': (context) =>
                    StreamProvider<List<Notifications>>.value(
                        value: NotificationManager(
                                FirebaseAuth.instance.currentUser.uid)
                            .notificationsStream,
                        child: NotificationView()),
                'History': (context) => StreamProvider<List<Order>>.value(
                    value: HistoryManager(FirebaseAuth.instance.currentUser.uid)
                        .obtainHistory,
                    child: History()),
                'Cart': (context) => StreamProvider<List<Product>>.value(
                    value: CartManager(FirebaseAuth.instance.currentUser.uid)
                        .productsInCart,
                    child: Cart()),

                //Account Page
                'Account': (context) => Account(),
                'Address': (context) =>
                    StreamProvider<List<ShippingAddress>>.value(
                        value: AddressDataManager(
                                FirebaseAuth.instance.currentUser.uid)
                            .address,
                        child: ShippingAddresses()),
                'CreditCard': (context) =>
                    StreamProvider<List<CreditCard>>.value(
                        value: CreditCardManager(
                                FirebaseAuth.instance.currentUser.uid)
                            .creditCardsStream,
                        child: CreditCards()),
                'Password': (context) => PasswordChange(),
                'Email': (context) => EmailChange(),
                'Nickname': (context) => StreamProvider<UserApp>.value(
                    value:
                        UserDataManager(FirebaseAuth.instance.currentUser.uid)
                            .userStream,
                    child: NicknameChange()),
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
