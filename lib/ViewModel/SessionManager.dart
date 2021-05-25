import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:like_eat/ViewModel/AppUrl.dart';
import 'package:like_eat/ViewModel/RegistrationManager.dart';
import 'package:like_eat/ViewModel/UserPreferences.dart';
import 'package:like_eat/Model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  AccountExists,
  Error,
  WrongPassword,
  WrongEmail,
  AccountDoesntExist,
  UserDisabled,
  UserLogged,
  EmailAlreadyUsed,
  WeakPassword,
  OperationNotAllowed
}

class AuthService {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //Interface of the FirebaseAuth

  UserAnon _userAnonFromFirebaseUser(User user) {
    return user != null
        ? UserAnon(user.uid, user.emailVerified, user.email)
        : null;
  }

  /*If the firebase User is Null then the login or the 
  registration failed it returns null else returns the UserApp with
  the data of the user
  */
  UserApp _userFromFirebaseUser(
      User user, String nickname, String name, String surname) {
    return user != null ? UserApp(name, surname, nickname, user.email) : null;
  }

  //auth state changes userAnon stream
  Stream<UserAnon> get userAnon {
    return _auth
        .authStateChanges()
        .map((User user) => _userAnonFromFirebaseUser(user));
  }

  //sign-in anonim
  /*This method interfaces with firebase and allows anonymous sign-in, 
  returns null if sign-in failed or user if sign-in was successful
  */
  Future signInAnom() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userAnonFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register new account and return the credentials fo the user just registered
  //Todo gestire meglio le eccezzioni
  Future registerUser(String email, String password, String nickname,
      String name, String surname) async {
    try {
      // create the Account in the DB of the authentication
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user; //Obtain the data of the created user

      if (user == null) {
        //Check if the creation was unsuccessful
        return Status.Error;
      }

      //Add the data of the new User in DB model
      bool esite = await RegistrationManager(user.uid)
          .addNewUser(email, password, nickname, name, surname);

      //Todo Manca il check per vedere se l'inserimento dei dati nel DB model è riuscita
      //Se è fallita bisogna cancellare i procedimenti fatti prima e segnalare Errore

      if (!user.emailVerified) {
        //If user is not verified
        await user.sendEmailVerification(); //Send the email verification link
      }

      return _userFromFirebaseUser(user, nickname, name,
          surname); //Return the data of the new User inside a class
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return Status.WrongEmail;
        case "email-already-in-use":
          return Status.EmailAlreadyUsed;
        case "operation-not-allowed":
          return Status.OperationNotAllowed;
        case "weak-password":
          return Status.WeakPassword;
        default:
          return Status.Error;
      }
    }
  }

  //Sign-in with email and Password
  //Precondition: the user must Exist in the DB model with his Data
  Future signInUser(String email, String password) async {
    try {
      //Try to login the user with the email and password in input
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;

      return user; //If there weren't exceptions return a code that says that the user is logged
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return Status.WrongEmail;
        case "user-disabled":
          return Status.UserDisabled;
        case "user-not-found":
          return Status.AccountDoesntExist;
        case "wrong-password":
          return Status.WrongPassword;
        default:
          return Status.Error;
      }
    }
  }

  //sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return Status.Error;
    }
  }

  /**
   * Send a mail at address in input with the link to reset the password of the user
   * with
   */
  void resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /**
   * Send a mail with the link to reset verify the account of the user with the email
   * in input
   */
  void sendVerificationEmailLink(String email) async {
    User user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
