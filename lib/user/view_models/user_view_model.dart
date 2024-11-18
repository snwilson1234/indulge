
import 'package:email_validator/email_validator.dart';

class UserViewModel {

  static String? validateUsername(String? value) {
    if (value != "") {
      return null;
    }
    else {
      return "Must input username";
    }
  }

  static String? validatePassword(String? value) {
    if (value != "") {
      return null;
    }
    else {
      return "Must input password";
    }
  }

  static String? validateEmail(String? value) {
    if (EmailValidator.validate(value!)) {
      return null;
    }
    else {
      return "Please enter valid email";
    }
  }

  static String? validatePasswordConfirmation(String? pass1, String? pass2) {
    if ( pass1 == pass2 ) {
      return null;
    }
    else {
      return "Password must match";
    }
  }

  static Map<String, bool> buttonList(strings) {
    List<String> list = [];
    List<bool> selected = [];
    for (String word in strings) {
      list.add(word);
      selected.add(false);
    }
    return Map.fromIterables(list, selected);
}

}