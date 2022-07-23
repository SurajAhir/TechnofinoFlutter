import 'package:shared_preferences/shared_preferences.dart';
class Shared_Preferences{
// Write DATA
  static Future<bool> setIsLoggedIn(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt("isLoggedIn", value);
  }

// Read Data
  static Future getIsLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt("isLoggedIn");
  }

  static Future<bool> setEmail(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt("email", value);
  }

// Read Data
  static Future getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt("email");
  }
}