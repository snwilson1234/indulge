

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

class UserViewModel extends ChangeNotifier{

  Map<String, bool> dietaryRestrictionCheckboxes = {};
  Map<String, bool> foodExperienceCheckboxes = {};

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

  void initDietaryButtonList(strings) {
    dietaryRestrictionCheckboxes = initXButtonList(strings);
  } 

  void initFoodButtonList(strings) {
    foodExperienceCheckboxes = initXButtonList(strings);
  } 

  Map<String, bool> initXButtonList(strings) {
    List<String> list = [];
    List<bool> selected = [];
    for (String word in strings) {
      list.add(word);
      selected.add(false);
    }
    return Map.fromIterables(list, selected);
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

  void setCheckbox(Map<String, bool> map, String key, bool? value) {
    map[key] = value!;
    notifyListeners(); 
  }
  

}