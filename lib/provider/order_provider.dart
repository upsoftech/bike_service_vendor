import 'package:flutter/cupertino.dart';
import '../model/order_model.dart';
import '../services/api_services.dart';

class OrderProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<OrderModel> _orderList = [];
  List<OrderModel> get orderList => _orderList;

  List<OrderModel> _orderList2 = [];

  List<OrderModel> get orderList2 => _orderList2;

  List<OrderModel> _orderList3 = [];
  List<OrderModel> get orderList3 => _orderList3;


  Future<void> getOrder(String status) async {
    _orderList.clear();
    _isLoading = true;
    await _apiServices.getOrderByStatus(status).then((value) {
      _orderList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> getOrder2(String status) async {
    _orderList2.clear();
    _isLoading = true;
    await _apiServices.getOrderByStatus(status).then((value) {
      _orderList2 = value;
      _isLoading = false;
      notifyListeners();
    });
  }
  Future<void> getOrder3(String status) async {
    _orderList3.clear();
    _isLoading = true;
    await _apiServices.getOrderByStatus(status).then((value) {
      _orderList3 = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  removeActiveOrder (int index){
    _orderList.removeAt(index);
    notifyListeners();
  }
}
