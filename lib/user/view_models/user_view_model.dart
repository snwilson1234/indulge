

class UserViewModel {

  String? validateUsername(String? value) {
    if (value != "") {
      return null;
    }
    else {
      return "Must input username";
    }
  }

    String? validatePassword(String? value) {
    if (value != "") {
      return null;
    }
    else {
      return "Must input password";
    }
  }

}