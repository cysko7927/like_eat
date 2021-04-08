import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:like_eat/Model/User.dart';
import 'package:like_eat/ViewModel/ViewModel.dart';
import 'package:like_eat/ViewModel/WebService.dart';

/**
 * This class allows to the view to obtain the data of a user
 * and the history of the orders
 */
class UserDataManager extends ChangeNotifier {
  UserApp _user;
  CollectionReference userReference =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;

  UserDataManager(this._uid);
  /**
   * This method obtain the data of a user and save it for the view
   */
  void obtainUserData(String uid) async {
    DocumentSnapshot result = await userReference.doc(_uid).get();

    _user = _userFromDocumentReference(result);
  }

  //Convert The Snapshot that contains the user in a object Useapp
  //that contains the data of the user
  //Precondition: The snapshot must contain the User with the correct parameters
  UserApp _userFromDocumentReference(DocumentSnapshot snapshot) {
    return UserApp(snapshot.data()["name"], snapshot.data()["surname"],
        snapshot.data()["nickname"], snapshot.data()["email"]);
  }

  //Getter

  //obtain the stream of the User  with uid = uidUser from this class
  Stream<UserApp> get userStream {
    obtainUserData(_uid); //Update the userApp inside the object
    return userReference.doc(_uid).snapshots().map(_userFromDocumentReference);
  }

  UserApp get user => _user;
}

//##########################################################################################################

/**
 * This class implements the logic to check if a new nickName of the user is valid
 * and ask to the server to modify
 */
class ModifyNickname extends ChangeNotifier {
  //bool _valid;
  bool _done;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('Users');
  String _uid;

  ModifyNickname(this._uid) {
    //_valid = false;
    _done = false;
  }

  /**
   * Ask to the server if the new nickname is valid and notify the view
  
  void nicknameIsValid(String newNick) async {
    _valid = await Webservice() //If the nick is valid returns true
        .checkNewNickName(newNick, ViewModel.userDataManager.user.nickname);
    notifyListeners();
  }*/

  /**
   * Ask to the DB to modify the nickname of a user, update the data of the user and notify
   * the view
   */
  void modifyNickname(String newNick) {
    usersReference.doc(_uid).update({'nickname': newNick});
    _done = true;
  }

  //bool get nickValid => _valid;
  bool get modificationDone => _done;
}

//##########################################################################################################

/**
 * This class implements the logic to ask to the server to modify the password of a user
 */
class ModifyPassword extends ChangeNotifier {
  bool _done;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;

  ModifyPassword(this._uid) {
    _done = false;
  }

  /**
   * Ask to the server to modify the nickname of a user, update the data of the user and notify
   * the view
   */
  Future<StatusModify> modifyPassword(
      String email, String oldPassword, String newPassword) async {
    User userReference = _auth.currentUser;

    try {
      EmailAuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);

      await userReference.reauthenticateWithCredential(credential);

      await userReference.updatePassword(newPassword);

      await usersReference.doc(_uid).update({'password': newPassword});

      _done = true;
    } catch (e) {
      switch (e.code) {
        case "user-mismatch":
          return StatusModify.UserMismatch;
        case "user-not-found":
          return StatusModify.UserNotFound;
        case "invalid-credential":
          return StatusModify.InvalidCredentials;
        case "invalid-email":
          return StatusModify.InvalidCredentials;
        case "wrong-password":
          return StatusModify.WrongPassword;
        case "weak-password":
          return StatusModify.PasswordWeak;
        default:
          return StatusModify.Error;
      }
    }
  }

  bool get modificationDone => _done;
}

class ModifyEmail extends ChangeNotifier {
  bool _done;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;

  ModifyEmail(this._uid) {
    _done = false;
  }

  /**
   * Ask to the server to modify the nickname of a user, update the data of the user and notify
   * the view
   */
  Future<StatusModify> modifyEmail(
      String oldEmail, String password, String newEmail) async {
    User userReference = _auth.currentUser;

    try {
      EmailAuthCredential credential =
          EmailAuthProvider.credential(email: oldEmail, password: password);

      await userReference.reauthenticateWithCredential(credential);

      await userReference.updateEmail(newEmail);

      await usersReference.doc(_uid).update({'email': newEmail});

      _done = true;
    } catch (e) {
      switch (e.code) {
        case "user-mismatch":
          return StatusModify.UserMismatch;
        case "user-not-found":
          return StatusModify.UserNotFound;
        case "invalid-credential":
          return StatusModify.InvalidCredentials;
        case "invalid-email":
          return StatusModify.InvalidCredentials;
        case "wrong-password":
          return StatusModify.WrongPassword;
        case "weak-password":
          return StatusModify.PasswordWeak;
        case "email-already-in-use":
          return StatusModify.EmailAlreadyUsed;
        default:
          return StatusModify.Error;
      }
    }
  }

  bool get modificationDone => _done;
}

//##########################################################################################################

/**
 * This class implements the logic to ask to the server to modify the name and Surname of a user
 */
class ModifyNameAndSurname extends ChangeNotifier {
  bool _done;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('Users');
  String _uid;

  ModifyNameAndSurname(this._uid) {
    _done = false;
  }

  /**
   * Ask to the server to modify the name and surname of a user, update the data of the user and notify
   * the view
   */
  void modifyNameAndSurname(String newName, String newSurname) {
    usersReference.doc(_uid).update({'name': newName, 'surname': newSurname});
    _done = true;
  }

  bool get modificationDone => _done;
}

enum StatusModify {
  PasswordWeak,
  UserMismatch,
  UserNotFound,
  InvalidCredentials,
  InvalidEmail,
  WrongPassword,
  Error,
  EmailAlreadyUsed,
}
