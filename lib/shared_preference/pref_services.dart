import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constant.dart';

class PrefService {
  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  setDeviceId(String deviceId){
    return setString(AppConstants.deviceIdKey, deviceId);
  }

  setRegId(String regId) {
    return setString(AppConstants.regIdKey, regId);
  }

getDeviceId(){
    return getString(AppConstants.deviceIdKey);
}

  getRegId() {
    return getString(AppConstants.regIdKey);
  }
  setGName(String gNameId) {
    return setString(AppConstants.gmailName, gNameId);
  }
  getGName(){
    return getString(AppConstants.gmailName);
  }
  setGEmail(String gEmailId) {
    return setString(AppConstants.gmailEmail, gEmailId);
  }
  getGEmail(){
    return getString(AppConstants.gmailEmail);
  }
  setGMobile(String gMobileId) {
    return setString(AppConstants.gmailMobile, gMobileId);
  }
  getGMobile(){
    return getString(AppConstants.gmailMobile);
  }

  setGPic(String gPicId) {
    return setString(AppConstants.gmailPic, gPicId);
  }
  getGPic(){
    return getString(AppConstants.gmailPic);
  }
  setMobile(String mobile) {
    return setString(AppConstants.mobileNoKey, mobile);
  }

  getMobile() {
    return getString(AppConstants.mobileNoKey);
  }

  setUserSession(bool value) {
    return setBool(AppConstants.userSessionKey, value);
  }

  getUserSession() {
    return getBool(AppConstants.userSessionKey);
  }

  //sets
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
