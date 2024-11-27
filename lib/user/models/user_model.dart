import 'dart:convert';

class UserData {

  String username;
  String password;
  Map<String, bool> preferences;
  Map<String, bool> dietaryRestrictions;

  UserData({
    required this.username,
    required this.password,
    required this.preferences,
    required this.dietaryRestrictions
  });

  
}
