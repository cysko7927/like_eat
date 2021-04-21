import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_eat/Model/User.dart';
import 'package:like_eat/ViewModel/AppUrl.dart';
import 'package:like_eat/ViewModel/UserPreferences.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class RegistrationManager extends ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final String uid;

  RegistrationManager(this.uid);
  /*
    Add a new User in the Database inside a new Document
    Precondition: In the database there isn't an user with the same email
  */
  Future<bool> addNewUser(String email, String password, String nickname,
      String name, String surname) async {
    return await users
        .doc(uid)
        .set({
          'email': email,
          'nickname': nickname,
          'name': name,
          'surname': surname,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  /**
   * Check if in the database there is an user with the email in input
   * Returns false if there isn't the user
   */
  Future<bool> checkEmailUser(String email) async {
    QuerySnapshot result = await users
        .where('email', isEqualTo: email)
        .get()
        .catchError((error) => throw Exception("Error in access DB"));

    if (result.size == 0) {
      return false;
    } else {
      return true;
    }
  }
}

/*class RegistrationManager extends ChangeNotifier {
  Status _registeredInStatus = Status.NotRegistered;

  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> register(
      String email,
      String password,
      String passwordConfirmation,
      String nickname,
      String name,
      String surname) async {
    final Map<String, dynamic> registrationData = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'nickname': nickname,
        'name': name,
        'surname': surname
      }
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    return await post(AppUrl.register,
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData['data'];

      UserApp authUser/*=
          User.fromJson(userData)*/
          ; //implementare metodo from json su User

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}*/
