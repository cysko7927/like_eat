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

  /**
   * This method obtain the data of a user and save it for the view
   */
  void obtainUserData(String nickname) async {
    _user = await Webservice().fetchUserData(nickname);
    notifyListeners();
  }

  //This method ask to the historyManager to obtain and save the order done by the user for the
  //view
  void obtainHistory() {
    ViewModel.historyManager.obtainHistory(user.nickname);
  }

  //Getter

  UserApp get user => _user;
}

//##########################################################################################################

/**
 * This class implements the logic to check if a new nickName of the user is valid
 * and ask to the server to modify
 */
class ModifyNickname extends ChangeNotifier {
  bool _valid;
  bool _done;

  ModifyNickname() {
    _valid = false;
    _done = false;
  }

  /**
   * Ask to the server if the new nickname is valid and notify the view
  */
  void nicknameIsValid(String newNick) async {
    _valid = await Webservice() //If the nick is valid returns true
        .checkNewNickName(newNick, ViewModel.userDataManager.user.nickname);
    notifyListeners();
  }

  /**
   * Ask to the server to modify the nickname of a user, update the data of the user and notify
   * the view
   */
  void modifyNickname(String newNick) {
    Webservice()
        .postNewNickName(newNick, ViewModel.userDataManager.user.nickname);
    ViewModel.userDataManager.obtainUserData(newNick);
    _done = true;
    notifyListeners();
  }

  bool get nickValid => _valid;
  bool get modificationDone => _done;
}

//##########################################################################################################

/**
 * This class implements the logic to ask to the server to modify the password of a user
 */
class ModifyPassword extends ChangeNotifier {
  bool _done;

  ModifyPassword() {
    _done = false;
  }

  /**
   * Ask to the server to modify the nickname of a user, update the data of the user and notify
   * the view
   */
  void modifyPassword(String newPassword) {
    Webservice()
        .postNewPassword(newPassword, ViewModel.userDataManager.user.nickname);
    ViewModel.userDataManager
        .obtainUserData(ViewModel.userDataManager.user.nickname);
    _done = true;
    notifyListeners();
  }

  bool get modificationDone => _done;
}

//##########################################################################################################

/**
 * This class implements the logic to ask to the server to modify the name and Surname of a user
 */
class ModifyNameAndSurname extends ChangeNotifier {
  bool _done;

  ModifyNameAndSurname() {
    _done = false;
  }

  /**
   * Ask to the server to modify the name and surname of a user, update the data of the user and notify
   * the view
   */
  void modifyNameAndSurname(String newName, String newSurname) {
    Webservice().postNewNameAndSurname(
        newName, newSurname, ViewModel.userDataManager.user.nickname);
    ViewModel.userDataManager
        .obtainUserData(ViewModel.userDataManager.user.nickname);
    _done = true;
    notifyListeners();
  }

  bool get modificationDone => _done;
}
