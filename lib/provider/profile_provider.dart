import 'package:flutter/cupertino.dart';

import '../services/api_services.dart';

class ProfileProvider extends ChangeNotifier{
  final ApiServices _apiServices = ApiServices();
  bool _isLoading=false;
  Map _profileData = {};
  bool get isLoading => _isLoading;
  dynamic get profileData => _profileData;

  Future<dynamic> getProfile() async {
    await _apiServices.getProfile().then((value) {
      _profileData = value;
      notifyListeners();
    });
    _isLoading = false;
    notifyListeners();
  }

}