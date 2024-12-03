import 'dart:convert';

class UserData {

  String username;
  String password;
  Map<String, bool> foodPreferences;
  Map<String, bool> dietaryRestrictions;
  int reviewed;
  int saved;
  double radius;

  UserData({
    required this.username,
    required this.password,
    required this.foodPreferences,
    required this.dietaryRestrictions,
    required this.reviewed,
    required this.saved, 
    required this.radius,
  });

  
}
