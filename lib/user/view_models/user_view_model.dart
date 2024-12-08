

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
    pricePoints: {},
    reviewed: 0, 
    saved: 0,
    radius: 1,
  );
  bool pricePointsChosen = false;

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

  void newUser() {
    _initDietaryCheckboxes(UserConstants.dietaryRestrictions);
    _initFoodCheckboxes(UserConstants.foodExperiences);
    _initPricePoints(UserConstants.pricePoints);
    _initRadius();
  }

  void _initDietaryCheckboxes(strings) {
    userData.dietaryRestrictions = initXMap(strings);
  } 

  void _initFoodCheckboxes(strings) {
    userData.foodPreferences = initXMap(strings);
  } 

  Map<String, bool> initXMap(strings) {
    List<String> list = [];
    List<bool> selected = [];
    for (String word in strings) {
      list.add(word);
      selected.add(false);
    }
    return Map.fromIterables(list, selected);
  }

  void _initPricePoints(strings) {
    userData.pricePoints = initXMap(strings);
    pricePointsChosen = false;
  }

  void _initRadius() {
    userData.radius = 1;
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

  bool arePricePointsChosen() {
    for (bool value in userData.pricePoints.values) {
      if (value) {
        return true;
      }
    }
    return false;
  }

  void updateModelRadius(double newRadius) {
    userData.radius = newRadius;
  }

  void updateModelPrices(String key) {
    userData.pricePoints[key] = !(userData.pricePoints[key]!);
    if (userData.pricePoints.values.contains(true)) {
      pricePointsChosen = true;
    }
    else {
      pricePointsChosen = false;
    }
    notifyListeners();
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