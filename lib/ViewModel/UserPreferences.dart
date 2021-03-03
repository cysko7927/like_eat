import 'package:like_eat/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

/**
 * This class being used for save in local the data of the user in the cache
 */
/*
class UserPreferences {
  void saveUser(UserApp user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("nickname", user.nickname);
    prefs.setString("name", user.name);
    prefs.setString("mail", user.mail);
    prefs.setString("surname", user.surname);
  }

  Future<UserApp> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String nickname = prefs.getString("nickname");
    String name = prefs.getString("name");
    String mail = prefs.getString("mail");
    String surname = prefs.getString("surname");

    return UserApp(name, surname, nickname, null, null,
        mail); //There aren't the password and the cart
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}*/
