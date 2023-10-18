

class AppConstants {
  static const String appName = 'Dry Cleaner Vendor';
  static const double appVersion = 0.0;
  static const String apiKey = 'AIzaSyDrKMGepGxVqb0UdeJqvd1v5NQycvrTUNE';
  static const String baseUrl = 'http://bike9pro.in/';
  static const String loginMobile = "$baseUrl/api/vendor/v1/login";
  static const String otpEndPoint = "$baseUrl/api/vendor/verify";
  static const String bannerEndPoint = "$baseUrl/api/banner";
  static const String orderEndPoint = "$baseUrl/api/order";
  static const String addImageEndPoint = "$baseUrl/api/order/";
  static const String isActiveEndPoint = "$baseUrl/api/vendor/status/";
  static const String subscriptionEndPoint = "$baseUrl/api/vendor/plan/";
  static const String subscriptionHistoryEndPoint = "$baseUrl/api/vendor/plan/";
  static const String updateProfileEndPont = "$baseUrl/api/vendor/profile/";
  static const String getProfileEndPont = "$baseUrl/api/vendor/";



  /// constant variable data

  static String regId="";
  static String mobile="";
  static bool userSession = false;
  static String deviceId="";
  static String gName='';
  static String gMobile='';
  static String gEmail='';
  static String gPic='';

  /// Shared Preference Keys ///
  static String regIdKey="regIdKey";
  static String mobileNoKey="mobileNoKey";
  static String userSessionKey="userSessionKey";
  static String deviceIdKey="deviceId";
  static String gmailName='gmailName';
  static String gmailMobile='gmailMobile';
  static String gmailEmail='gmailEmail';
  static String gmailPic='gmailPic';


}