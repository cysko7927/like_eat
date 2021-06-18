import 'package:flutter/material.dart';
import 'package:like_eat/ViewModel/SessionManager.dart';

class SignUp extends StatefulWidget {
  final Function goToSignIn;

  SignUp(this.goToSignIn);
  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  //Booleans for checkboxs and properties of the text fields
  bool _obscureTextFirst = true;
  bool _obscureTextSecond = true;
  bool _privacyTermValue = false;
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControllerFirst = TextEditingController();
  TextEditingController passwordControllerSecond = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  //State of the Text Fields
  String email = '';
  String password1 = '';
  String password2 = '';
  String nickname = '';
  String name = '';
  String surname = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    //Check if the email is valid in the format with this regular expression
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    //Check if the passwords are equal
    bool passwordsEqual = password1 == password2;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_name_text"),
                    validator: (value) => value.isEmpty ? "Enter a name" : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_surname_text"),
                    validator: (value) =>
                        value.isEmpty ? "Enter a surname" : null,
                    onChanged: (val) {
                      setState(() => surname = val);
                    },
                    controller: surnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Surname',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_nickname_text"),
                    validator: (value) =>
                        value.isEmpty ? "Enter a nickname" : null,
                    onChanged: (val) {
                      setState(() => nickname = val);
                    },
                    controller: nicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Nickname',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_email_textForm"),
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
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_password1_textForm"),
                    validator: (value) => value.length < 8
                        ? "Enter a Password greater at least 8 characters"
                        : null, //The password must be greater of 8
                    onChanged: (val) {
                      setState(() => password1 = val);
                    },
                    obscureText: _obscureTextFirst,
                    controller: passwordControllerFirst,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggle1,
                        child: Icon(
                          _obscureTextFirst
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30.0, right: 30, top: 5, bottom: 5),
                  child: TextFormField(
                    key: ValueKey("sign_up_password2_textForm"),
                    validator: (value) => value.isEmpty || !passwordsEqual
                        ? "The passwords must be equal"
                        : null, //The two passowrd inserted by user in the form must be equal
                    onChanged: (val) {
                      setState(() => password2 = val);
                    },
                    obscureText: _obscureTextSecond,
                    controller: passwordControllerSecond,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.security),
                      suffixIcon: InkWell(
                        onTap: _toggle2,
                        child: Icon(
                          _obscureTextSecond
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize:
                            14.0)), //Text error that will be printed if there are errors in the registration process
                FormField<bool>(
                  initialValue: _privacyTermValue,
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              key: ValueKey("sign_up_checkbox"),
                              // 3
                              value: state.value,
                              onChanged: (bool val) => setState(() {
                                // 4
                                _privacyTermValue = val;
                                // 5
                                state.didChange(val);
                              }),
                            ),
                            const Text(
                                "I agree to the Terms of Services and Privacy Policy."),
                          ],
                        ),
                        // 6
                        state.errorText == null
                            ? Text("")
                            : Text(state.errorText,
                                style: TextStyle(color: Colors.red)),
                      ],
                    );
                  },
                  // 7
                  validator: (value) => !value
                      ? "You must agree before proceeding"
                      : null, //The two passowrd inserted by user in the form must be equal
                ),

                Container(
                  child: FlatButton(
                    key: ValueKey("sign_up_register_button"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () async {
                      //If the form is valid
                      if (_formKey.currentState.validate()) {
                        //Try to register the user
                        dynamic result = await _auth.registerUser(
                            email, password1, nickname, name, surname);

                        if (result is Status) {
                          //If the operation of registration was unsuccessful
                          setState(() => error = obtainStringError(
                                  result) //Obtain and print the error message at the user
                              );
                        }
                        //If the registration was a successful the wrapper will obtain from the Provider
                        //a user valid and will built the homepage
                      }
                      //check Input provided by the usere: two password the same and if email not already present in db ...
                      //check also if agreed on privacy terms if everything ok go on Homepage

                      //if not agreed on privacy term
                      //POPUP to agree on check privacy

                      //if password not same
                      //POP UP with different password

                      //if email already present
                      //POPUP email already registered
                    },
                    child: Text(
                      "Create account",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Text("Have an account?")),
                    FlatButton(
                        onPressed: () {
                          widget
                              .goToSignIn(); //If the user press the button SignIn,ask to the widget Authenticate to built the SignIn widget
                        },
                        child: Text("Sign in"))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _toggle1() {
    setState(() {
      _obscureTextFirst = !_obscureTextFirst;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureTextSecond = !_obscureTextSecond;
    });
  }

  /**
   * Translate a Status Error in a String that describes the error ready to be printed
   */
  String obtainStringError(Status status) {
    switch (status) {
      case Status.WrongEmail:
        return "Please insert a valid email";
      case Status.EmailAlreadyUsed:
        return "This email is already used by another user";
      case Status.OperationNotAllowed:
        return "Operation Not Allowed";
      case Status.WeakPassword:
        return "Password too weak please insert a strong one";
      default:
        return "Error of connection";
    }
  }
}
