
//SHARED PREFERENCES

import 'package:shared_preferences/shared_preferences.dart';

class helperFunction{
  //keys
  static String userLoggedInkey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

//saving data to shared preferences

  //saving user logged in data to shared preference
  static Future<bool> saveUserLoggedInStatus( bool isUserLoggedIn) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInkey, isUserLoggedIn);
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
  static Future<bool?> getUserLOggedInStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInkey);
  }
}