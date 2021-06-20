import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';

class EmailValidator {
  static String validator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return value.isEmpty || !emailValid
        ? "Enter a valid email"
        : null; //If the email is not valid print at the user to insert a valid Email
  }
}

class PasswordValidator {
  static String validator(String value) {
    return value.length < 8
        ? "Enter a Password greater at least 8 characters"
        : null; //The password must be greater of 8
  }
}

class SignIn extends StatefulWidget {
  final Function goToSignUp;

  SignIn(this.goToSignUp);
  @override
  _State createState() => _State();
}

class _State extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  //State
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    //Check if the email is valid in the format with this regular expression
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
                child: TextFormField(
                  key: ValueKey("sign_in_email_text"),

                  validator: (value) => value.isEmpty || !emailValid
                      ? "Enter a valid email"
                      : null, //If the email is not valid print at the user to insert a valid Email
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 30.0, right: 30, top: 15, bottom: 15),
                child: TextFormField(
                  key: ValueKey("sign_in_password_text"),

                  validator: (value) => value.length < 8
                      ? "Enter a Password greater at least 8 characters"
                      : null, //The password must be greater of 8
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: _obscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Password',
                    prefixIcon: Icon(Icons.security),
                    suffixIcon: InkWell(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  key: ValueKey("sign_in_login_button"),
                  color: Colors.blue[400],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () async {
                    //If the form is valid
                    if (_formKey.currentState.validate()) {
                      //Try to login the user
                      dynamic result = await _auth.signInUser(email, password);

                      if (result is Status) {
                        //If the operation of login was unsuccessful
                        setState(() => error = obtainStringError(
                                result) //Obtain and print the error message at the user
                            );
                      }
                      //If the login was a successful the wrapper will obtain from the Provider
                      //a user valid and will built the homepage
                    }
                    //For now it just print the email and password on the terminal
                    print(emailController.text);
                    print(passwordController.text);

                    //we need to check if credential are correct in the database and if there are we go to the homepage

                    //otherwise we remain here popping a pop up that says: wrong credential
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                child: Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, 'LostPassword');
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                      child: FlatButton(
                    key: ValueKey("sign_in_enterSignUp_button"),
                    color: Colors.blue[400],
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      widget
                          .goToSignUp(); //If the user press the button SignUp,ask to the widget Authenticate to built the SignUp widget
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String obtainStringError(Status status) {
    switch (status) {
      case Status.WrongEmail:
        return "The email inserted is not valid";
      case Status.UserDisabled:
        return "Your account is Disabled";
      case Status.AccountDoesntExist:
        return "An account associated to this email doesn't exist'";
      case Status.WrongPassword:
        return "The password inserted is wrong!";
      default:
        return "Error of connection";
    }
  }
}
