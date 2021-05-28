import 'package:flutter_test/flutter_test.dart';
import 'package:like_eat/View/Wrapper/Authenticate/SignInView.dart';

void main() {
  test("empty email returns error strings", () {
    //setup

    //run
    var result = EmailValidator.validator("asdas");

    //verify

    expect("Enter a valid email", result);
  });

  test("valid email returns null", () {
    //setup

    //run
    var result = EmailValidator.validator("cysko7927@gmail.com");

    //verify

    expect(null, result);
  });

  test("empty password returns error strings", () {
    //setup

    //run
    var result = PasswordValidator.validator("asd");

    //verify

    expect("Enter a Password greater at least 8 characters", result);
  });

  test("valid password returns null", () {
    //setup

    //run
    var result = PasswordValidator.validator("dariocrispi");

    //verify

    expect(null, result);
  });
}
