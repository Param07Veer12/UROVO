import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass{
  static  late SharedPreferences prefs ;
  static  initializeSharedPref()async{
    prefs=  await SharedPreferences.getInstance();
  }
}

const tokenKey="tokenKey";
const userAlreadyLoggedInKey="userAlreadyLoggedInKey";
const userTypeKey="userTypeKey";
const lastLoginKey="lastLoginKey";
const timeOutKey="timeOutKey";