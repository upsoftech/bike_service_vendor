import 'dart:developer';

import 'package:bike_services_vendor/services/api_services.dart';
import 'package:flutter/cupertino.dart';

class DashboardProvider extends ChangeNotifier{
  final ApiServices _apiServices = ApiServices();
  bool _isLoading = false;
  List _bannerList=[];
  List _userActiveList=[];

  List get bannerList=>_bannerList;
  List get userActiveList=>_userActiveList;
  int _currentIndex = 0;
  int get currentIndex =>_currentIndex;
  bool get isLoading => _isLoading;

  Future<dynamic> getBanners() async {
    _isLoading = true;
    log("message$getBanners");
    await _apiServices.getBanner().then((value) {
      _bannerList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  setCurrentIndex(int i){
    _currentIndex = i;
    notifyListeners();
  }

  /// User Active and Deactivate ///
    Future<dynamic>isActive()async{
    _isLoading=true;
    await _apiServices.userActive().then((value){
      _userActiveList=value;
      _isLoading=false;
      notifyListeners();

    });
    }


}