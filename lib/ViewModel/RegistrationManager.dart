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

      User authUser/*=
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
}
