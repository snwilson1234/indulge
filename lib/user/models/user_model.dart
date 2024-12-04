import 'dart:convert';

class UserData {

  String username;
  String password;
  String email;
  Map<String, bool> foodPreferences;
  Map<String, bool> dietaryRestrictions;
  List<dynamic> pricePoints;
  int reviewed;
  int saved;
  double radius;

  UserData({
    required this.username,
    required this.password,
    required this.email,
    required this.foodPreferences,
    required this.dietaryRestrictions,
    required this.pricePoints,
    required this.reviewed,
    required this.saved, 
    required this.radius,
  });

  
}
