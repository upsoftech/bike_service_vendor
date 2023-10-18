
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkCalls {
  /// Post Api Call ///

  Future<dynamic> post(String url, Object map) async {
    log("$url");
    log("$map");
    var response = await http.post(Uri.parse(url), body: map);
    checkAndThrowError(response);
    return response.body;
  }

  /// Post Api Call ///

  Future<dynamic>patch(String url, Object map) async {
    var response = await http.post(Uri.parse(url), body: map);
    checkAndThrowError(response);
    return response.body;
  }

  /// get Api call ///
  Future<dynamic> get(String url) async {
    var response = await http.get(Uri.parse(url));
    checkAndThrowError(response);
    return response.body;
  }

  /// delete Api Call ///
  Future<dynamic> delete(String url, Map<String, String> map) async {
    var response = await http.delete(Uri.parse(url), body: map);
    checkAndThrowError(response);
    return response.body;
  }

  /// throwing  error ///

  static void checkAndThrowError(http.Response response) {
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
