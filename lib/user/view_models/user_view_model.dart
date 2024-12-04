

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/models/user_model.dart';

class UserViewModel extends ChangeNotifier{

  final userData = UserData(
    username: "", 
    password: "", 
    email: "",
    foodPreferences: {}, 
    dietaryRestrictions: {}, 
    pricePoints: [],
    reviewed: 0, 
    saved: 0,
    radius: 1,
  );

  // ----------------------------------------------------------------------------------------------------
  // --------------------------------- Static utility methods -------------------------------------------
  // ----------------------------------------------------------------------------------------------------

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

  // TODO: Method checks if user/pass combo already exists in DB

  // ----------------------------------------------------------------------------------------------------
  // --------------------------------- Instance methods -------------------------------------------------
  // ----------------------------------------------------------------------------------------------------

  void loadUserAccountInfo() {

  }

  void initDietaryButtonList(strings) {
    userData.dietaryRestrictions = initXButtonList(strings);
  } 

  void initFoodButtonList(strings) {
    userData.foodPreferences = initXButtonList(strings);
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

  String? checkOldPassword(String? pass) {
    if ( pass == userData.password ) {
      return null;
    }
    else {
      return "Incorrect password";
    }
  }

  void updateModelPriceAndRadius(List<dynamic> newPricePoints, double newRadius) {
    userData.pricePoints = newPricePoints;
    userData.radius = newRadius;
  }

  void updateUsername(String username) {
    userData.username = username;
  }

  void updatePassword(String password) {
    userData.password = password;
  }

  void updateEmail(String email) {
    userData.email = email;
  }

  void updateReviewed(bool addedOrDeleted) {
    userData.reviewed += (addedOrDeleted) ? 1 : -1;
  }

  void updateSaved(bool addedOrDeleted) {
    userData.saved += (addedOrDeleted) ? 1 : -1;
  }

  // For debugging purposes
  void info() {
    print(userData.username);
    print(userData.password);
    print(userData.email);
    print(userData.foodPreferences);
    print(userData.dietaryRestrictions);
    print(userData.pricePoints);
    print(userData.reviewed);
    print(userData.saved);
    print(userData.radius);
  }

  void updateDatabase(){
    // TODO: Update database with all user data
  }
  

}