import 'dart:developer';

import 'package:flutter/material.dart';

import '../shared_preference/pref_services.dart';
import '../utils/app_constant.dart';




class PrefProvider extends ChangeNotifier {
  final PrefService _prefService = PrefService();

  PrefProvider() {
    getRegId();
    getMobile();
  }

  /// getting RegId
  Future<void> getRegId() async {
    AppConstants.regId = await _prefService.getRegId()??"";
    // log("message${_prefService.getRegId()}");
    notifyListeners();
  }

  /// getting Mobile
  Future<void> getMobile() async {
    AppConstants.mobile = await _prefService.getMobile()??"";
    notifyListeners();
  }

  /// getting User Session
  Future<void> getUserSession() async {
    AppConstants.userSession = await _prefService.getUserSession() ?? false;
    notifyListeners();
  }

}
