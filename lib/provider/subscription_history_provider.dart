import 'package:flutter/cupertino.dart';

import '../model/subscription_model.dart';
import '../services/api_services.dart';

class SubscriptionHistoryProvider extends ChangeNotifier{
  final ApiServices _apiServices = ApiServices();
  bool _isLoading=false;
  bool get isLoading => _isLoading;
  List<SubscriptionHistoryModel> _subscriptionHistory = [];

  List<SubscriptionHistoryModel> get subscriptionHistory => _subscriptionHistory;
  Future<void> getSubscriptionHistory() async {
    _isLoading = true;
    await _apiServices.getSubscription().then((value) {
      _subscriptionHistory = value;
      _isLoading = false;
      notifyListeners();
    });
  }


}