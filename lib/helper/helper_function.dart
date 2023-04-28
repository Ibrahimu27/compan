
//SHARED PREFERENCES

import 'package:shared_preferences/shared_preferences.dart';

class helperFunction{
  //keys
  static String userLoggedInkey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userEmailK = "USEREMAILKEY";

//saving data to shared preferences

  //saving user logged in data to shared preference
  static Future<bool> saveUserLoggedInStatus( bool isUserLoggedIn) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInkey, isUserLoggedIn);
  }

  //saving userEmail
  static Future<bool> saveUserEmail(String userEmail) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailK, userEmail);
  }

  //saving user name data to shared preferences
  static Future<bool> SaveUserNameSF( String userName) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  //saving user email data to shared preferences
  static Future<bool> SaveUserEmailSF( String userEmail) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userLoggedInkey, userEmail);
  }

// getting data to shared preferences
  static Future<bool> getUserLOggedInStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInkey)!;
  }

  //userEmail
  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailK);
  }

  //username
  static Future<String> getUserNameFromSf() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey)!;
  }

  //user email
  static Future<String> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey)!;
  }
}