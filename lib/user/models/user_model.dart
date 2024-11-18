import 'dart:convert';

class UserData {

  var _username;
  var _password;
  var _preferences;
  var _dietaryRestrictions;

  UserData.all( String username, String password, preferences, dietaryRestrictions ) {
    this._username = username;
    this._password = password;
    this._preferences = jsonDecode(preferences);
    this._dietaryRestrictions = dietaryRestrictions;
  }

  UserData.userPass( String username, String password ) {
    this._username = username;
    this._password = password;
  }

  getPreferences() {

  }
}
