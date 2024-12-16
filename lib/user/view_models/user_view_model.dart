

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/models/user_model.dart';
import 'package:indulge/user/services/account_info_service.dart';

class UserViewModel extends ChangeNotifier{

  // Holds the user's account data
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
  // Keeps track of whether a user has chosen preferred price points yet
  bool pricePointsChosen = false;
  // Service to interact with database
  static final AccountInfoService accountInfoService = AccountInfoService();
  // Holds the account info
  List<Map<String, dynamic>> accountInfo = [];

  // ----------------------------------------------------------------------------------------------------
  // --------------------------------- Static utility methods -------------------------------------------
  // ----------------------------------------------------------------------------------------------------


  /// Validates whether a user's current email is a valid address
  static String? validateEmail(String? value) {
    if (EmailValidator.validate(value!)) {
      return null;
    }
    else {
      return "Please enter valid email";
    }
  }

  /// Validates whether a user correctly confirms their password or not
  /// Checks whether [pass1] equals [pass2]
  static String? validatePasswordConfirmation(String? pass1, String? pass2) {
    if ( pass1 == pass2 ) {
      return null;
    }
    else {
      return "Password must match";
    }
  }

  // ----------------------------------------------------------------------------------------------------
  // --------------------------------- Instance methods -------------------------------------------------
  // ----------------------------------------------------------------------------------------------------

  void fetchAccountInfo() async {
    accountInfo = await accountInfoService.getAllAccountInfo();
    notifyListeners();
  }


  /// Validates whether a user has entered a username or not yet
  String? validateUsername(String? username, String? password) {
    if (username == "") {
      return "Must input username";
    }
    else if (!userExists(username!)) {
      return "Username not found";
    }
    else {
      return null;
    }
  }

  /// Validates whether a user has entered a password or not yet
  String? validatePassword(String? username, String? password) {
    if (password == "") {
      return "Must input username";
    }
    else if (userExists(username!) && !passwordMatchesUsername(username, password!)) {
      return "Password doesn't match";
    }
    else {
      return null;
    }
  }

  /// Check if the username exists in the database
  bool userExists(String username) {
    for (Map<String, dynamic> user in accountInfo) {
      if (user["username"] == username) {
        return true;
      }
    }
    return false;
  }

  /// Check if a password matches a username
  bool passwordMatchesUsername(String username, String password) {
    for (Map<String, dynamic> user in accountInfo) {
      if (user["username"] == username && user["password"] == password) {
        return true;
      }
    }
    return false;
  }

  /// Loads preexisting user account info into [UserData] model
  void loadUserAccountInfo(String username, String password) async {
    final user = await accountInfoService.getAccountInfo(username, password);
    pricePointsChosen = true;
    if (user != null) {
      userData.username = user.username;
      userData.password = user.password;
      userData.email = user.email;
      userData.foodPreferences = user.foodPreferences;
      userData.dietaryRestrictions = user.dietaryRestrictions;
      userData.pricePoints = user.pricePoints;
      userData.reviewed = user.reviewed;
      userData.saved = user.saved;
      userData.radius = user.radius;
    }
  }

  /// Initializes a new user using the [UserData] model
  void newUser() {
    _initDietaryCheckboxes(UserConstants.dietaryRestrictions);
    _initFoodCheckboxes(UserConstants.foodExperiences);
    _initPricePoints(UserConstants.pricePoints);
    _initRadius();
  }

  /// Initializes the user's dietary restrictions checkboxes to be unchecked
  /// Used when new user creation process engaged
  void _initDietaryCheckboxes(strings) {
    userData.dietaryRestrictions = initXMap(strings);
  } 

  /// Initializes the user's food preferences checkboxes to be unchecked
  /// Used when new user creation process engaged
  void _initFoodCheckboxes(strings) {
    userData.foodPreferences = initXMap(strings);
  } 

  /// Initializes a map of [strings] keys to all equal [false]
  /// Used when new user creation process engaged to initialize the checkboxes
  Map<String, bool> initXMap(strings) {
    List<String> list = [];
    List<bool> selected = [];
    for (String word in strings) {
      list.add(word);
      selected.add(false);
    }
    return Map.fromIterables(list, selected);
  }

  /// Initializes the user's price points selection to be none
  /// Used when new user creation process engaged
  void _initPricePoints(strings) {
    userData.pricePoints = initXMap(strings);
    pricePointsChosen = false;
  }

  /// Initializes the user's restaurant search radius to 1
  /// Used when new user creation process engaged
  void _initRadius() {
    userData.radius = 1;
  }

  /// Sets the value of the checkbox at [map[key]] to be [value]
  /// Allows for the views to update either [foodPreferences] or [dietaryRestrictions] with one method
  void setCheckbox(Map<String, bool> map, String key, bool? value) {
    map[key] = value!;
    notifyListeners(); 
  }

  /// Checks if the user's current/old password matches the [pass] they typed
  /// Only used for the password changing feature currently
  String? checkOldPassword(String? pass) {
    if ( pass == userData.password ) {
      return null;
    }
    else {
      return "Incorrect password";
    }
  }

  /// Updates the user's search radius to be [newRadius] to find new restaurants
  /// Will update as long as 1 <= [newRadius] <= 15
  void updateModelRadius(double newRadius) {
    if (newRadius <= 15 && newRadius >= 1) {
      userData.radius = newRadius;
      notifyListeners();
    }

  }

  /// Updates the user's preferred [pricePoints] based on the [key] given
  /// Will flip whatever boolean value was there due to the nature of the price points toggle buttons
  /// Also updates the boolean flag [pricePointsChosen] that tracks whether any price points are currently selected
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

  /// Updates the username of the user to be [username]
  void updateUsername(String username) {
    userData.username = username;
  }

  /// Updates the password of the user to be [password]
  void updatePassword(String password) {
    userData.password = password;
  }

  /// Updates the email address of the user to be [email]
  void updateEmail(String email) {
    userData.email = email;
  }

  /// Updates the user's number of reviewed restaurants
  /// [addedOrDeleted] parameter controls whether to add [true] or subtract [false] 1 
  void updateReviewed(bool addedOrDeleted) {
    userData.reviewed += (addedOrDeleted) ? 1 : -1;
    notifyListeners();
  }

  /// Updates the user's number of saved restaurants
  /// [addedOrDeleted] parameter controls whether to add [true] or subtract [false] 1 
  void updateSaved(bool addedOrDeleted) {
    userData.saved += (addedOrDeleted) ? 1 : -1;
    notifyListeners();
  }

  /// For debugging purposes
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

  /// Naive implementation (for prototype) to update database
  /// Updates all possible user data all at once
  void updateDatabase(bool newUser) {

    if (newUser) {
      insertDBNewUserAccountInfo();
    }
    else {
      updateDBAccountInfo();
    }
    updateDBDietaryRestrictions();
    updateDBPreferences();
    updateDBPrices();

  }

  void insertDBNewUserAccountInfo() {
    final AccountInfoData newData = AccountInfoData(
      username: userData.username, 
      password: userData.password, 
      email: userData.email, 
      reviewed: userData.reviewed, 
      saved: userData.saved, 
      radius: userData.radius
    );
    accountInfoService.insertAccountInfo(newData);
  }

  void updateDBAccountInfo() {
    final AccountInfoData newData = AccountInfoData(
      username: userData.username, 
      password: userData.password, 
      email: userData.email, 
      reviewed: userData.reviewed, 
      saved: userData.saved, 
      radius: userData.radius
    );
    accountInfoService.updateAccountInfo(newData, newData.username);
  }

  void updateDBPreferences() {
    final List<String> preferences = [];
    for (MapEntry<String, bool> entry in userData.foodPreferences.entries) {
      if (entry.value) {
        preferences.add(entry.key);
      }
    }
    accountInfoService.updatePreferences(userData.username, preferences);
  }
  
  void updateDBDietaryRestrictions() {
    final List<String> restrictions = [];
    for (MapEntry<String, bool> entry in userData.dietaryRestrictions.entries) {
      if (entry.value) {
        restrictions.add(entry.key);
      }
    }
    accountInfoService.updateDietaryRestrictions(userData.username, restrictions);
  }

  void updateDBPrices() {
    final List<int> prices = [];
    for (MapEntry<String, bool> entry in userData.pricePoints.entries) {
      if (entry.value) {
        prices.add(entry.key.length);
      }
    }
    accountInfoService.updatePrices(userData.username, prices);
  }


}