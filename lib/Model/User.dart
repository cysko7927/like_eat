import 'dart:convert';

class User {
  final String _name;
  final String _surname;
  final String _nickname;
  String _password;

  //Constructor
  User(this._name, this._surname, this._nickname, this._password);

  //Getter
  String getName() {
    return this._name;
  }

  String getSurname() {
    return this._surname;
  }

  String getNickname() {
    return this._nickname;
  }

  String getPassword() {
    return this._password;
  }

  //Setter
  setPassword(String password) {
    this._password = password;
  }

  //Utility
  User copyWith({
    String name,
    String surname,
    String nickname,
    String password,
  }) {
    return User(
      _name ?? this._name,
      _surname ?? this._surname,
      _nickname ?? this._nickname,
      _password ?? this._password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'surname': _surname,
      'nickname': _nickname,
      'password': _password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      map['name'],
      map['surname'],
      map['nickname'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(_name: $_name, _surname: $_surname, _nickname: $_nickname, _password: $_password)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o._name == _name &&
        o._surname == _surname &&
        o._nickname == _nickname &&
        o._password == _password;
  }

  @override
  int get hashCode {
    return _name.hashCode ^
        _surname.hashCode ^
        _nickname.hashCode ^
        _password.hashCode;
  }
}
