import 'dart:convert';
import 'dart:developer';
import 'package:bike_services_vendor/model/subscription_model.dart';
import 'package:http/http.dart' as http;
import '../model/order_model.dart';
import '../shared_preference/pref_services.dart';
import '../utils/app_constant.dart';
import 'network_cell.dart';

class ApiServices {
  final networkCalls = NetworkCalls();

  /// login with mobile number ///

  Future<dynamic> logInMb(String mobile) async {
    var data =
        await networkCalls.post(AppConstants.loginMobile, {"mobile": mobile});
    log("mobile$data");

    return jsonDecode(data);
  }

  /// Otp verification ///
  Future<dynamic> verifyOtp(mobile, otp) async {
    var data = await networkCalls
        .post(AppConstants.otpEndPoint, {"mobile": mobile, "otp": otp});
    return jsonDecode(data);
  }

  /// Get Banner From the Server ///

  Future<dynamic> getBanner() async {
    var data = await networkCalls.get(AppConstants.bannerEndPoint);

    return jsonDecode(data);
  }

  /// login with Google ///

  Future<dynamic> googleLogin1(String email) async {
    var data =
        await networkCalls.post(AppConstants.loginMobile, {"email": email});
    log("email$data");

    return jsonDecode(data);
  }

  // /// Update Profile from The Server ///
  //
  // Future<dynamic> updateProfile(Map<String, dynamic> mapData) async {
  //   var regIds = PrefService().getRegId();
  //   var response = await http.patch(
  //       Uri.parse(AppConstants.updateProfileEndPont + regIds),
  //       body: mapData);
  //   return json.decode(response.body);
  // }

  /// Get Profile details from the server ///
  Future<dynamic> getProfile() async {
    var p = PrefService().getRegId();
    var data = await networkCalls.get("${AppConstants.getProfileEndPont}$p");
    return jsonDecode(data);
  }

  /// Get Order from the server ///

  Future<List<OrderModel>> getOrderByStatus(String status) async {
    var p = PrefService().getRegId();
    List<OrderModel> myList = [];
    log("Url : ${"${AppConstants.orderEndPoint}?orderStatus=$status&vendorId=$p"}");
    //?orderStatus=process&vendorId=6516b3ea1fc716bb0f09c7a3
    var data = await networkCalls.get("${AppConstants.orderEndPoint}?orderStatus=$status&vendorId=$p");

    log("List length before removal:${jsonDecode(data)}");
    for (var i in jsonDecode(data)) {
      myList.add(OrderModel.fromJson(i));
    }
    return myList;
  }

  /// Add Bike Image on the Server ///
  Future<dynamic> addImage(path1, path2, path3, path4, orderId) async {
    var response;
    var uri = Uri.parse(AppConstants.addImageEndPoint + orderId);
    log("Image : $uri");
    log("Image : $path1");
    log("Image : $path2");
    log("Image : $path3");
    log("Image : $path4");

    try {
      var request = http.MultipartRequest(
          'PATCH', Uri.parse(AppConstants.addImageEndPoint + orderId));

      // Create and add each MultipartFile separately
      if (path1 != null && path2 != null && path3 != null && path4 != null) {
        http.MultipartFile multipartFile1 =
        await http.MultipartFile.fromPath('frontImage', path1);
        http.MultipartFile multipartFile2 =
        await http.MultipartFile.fromPath('backImage', path2);
        http.MultipartFile multipartFile3 =
        await http.MultipartFile.fromPath('rightImage', path3);
        http.MultipartFile multipartFile4 =
        await http.MultipartFile.fromPath('leftImage', path4);

        request.files.add(multipartFile1);
        request.files.add(multipartFile2);
        request.files.add(multipartFile3);
        request.files.add(multipartFile4);
        log("Image : ${request.files}");

        request.fields["orderStatus"] ="process";
        response = await request.send();
        if (response.statusCode == 200) {
          print('Image uploaded successfully');
        } else {
          print('Image upload failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error during image upload: $e');
    }

    return response;
  }


  /// update profile image on the server///
  Future<dynamic> updateProfile(filePathProImg, name, mobile, email,notificationId) async {
    var p = PrefService().getRegId();

    var uri = Uri.parse(AppConstants.updateProfileEndPont + p);

    log("url : $uri");
    var request = http.MultipartRequest("PATCH", uri);

    if(filePathProImg!=null){
      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('profilePic', filePathProImg);
      request.files.add(multipartFile);
    }

    // Add additional string parameter
    request.fields['name'] = name;
    request.fields['mobile'] = mobile;
    request.fields['email'] = email;
    request.fields['notificationId'] = notificationId;
    log("message99999${request.fields}");
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Uploaded!");
    } else {
      print("HTTP request failed with status code ${response.statusCode}");
    }
    var data = await http.Response.fromStream(response);

    return jsonDecode(data.body);
  }

  /// Send data  on the server throw pick button///
  // Future<dynamic> sendToPicked(pick, orderId) async {
  //   // var p=PrefService().getRegId();
  //
  //   var uri = Uri.parse("${AppConstants.orderEndPoint}/$orderId" );
  //
  //   log("url : $uri");
  //   var request = http.MultipartRequest("PATCH", uri);
  //   // Add additional string parameter
  //   request.fields['orderStatus'] = pick;
  //
  //   var response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print("Uploaded!");
  //   } else {
  //     print("HTTP request failed with status code ${response.statusCode}");
  //   }
  //   var data = await http.Response.fromStream(response);
  //
  //   return jsonDecode(data.body);
  // }
  Future<dynamic> sendToPicked(pick, orderId) async {
    var uri = Uri.parse("${AppConstants.orderEndPoint}/$orderId");



    try {
      log("urlCheck : $uri");
    var request = http.MultipartRequest("PATCH", uri);
    // Add additional string parameter
    request.fields['orderStatus'] = pick;
      var response = await request.send();
      print("Response body: ${await response.stream.bytesToString()}");
      if (response.statusCode == 200) {
        print("Updated successfully!");

      } else {
        print("HTTP request failed with status code ${response.statusCode}");
        print("Response body: ${await response.stream.bytesToString()}");
      }

      var data = await http.Response.fromStream(response);
      return jsonDecode(data.body);
    } catch (e) {
      print("Error: $e");
      return {"error": "An error occurred while sending the request."};
    }
  }


  /// User Active Oe Deactivate///
  Future<dynamic> userActive() async {
    var p = PrefService().getRegId();
    var deviceId = PrefService().getDeviceId();

    var uri = Uri.parse(AppConstants.isActiveEndPoint + p);

    log("url : $uri");
    var request = http.MultipartRequest("PATCH", uri);
    request.fields['notificationId'] = deviceId;
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Uploaded!");
    } else {
      print("HTTP request failed with status code ${response.statusCode}");
    }
    var data = await http.Response.fromStream(response);

    return jsonDecode(data.body);
  }

  /// upload image on the server///
  Future<dynamic> subscriptionPlan(
      String title, subTitle, count, price) async {
    var p = PrefService().getRegId();

    var uri = Uri.parse(AppConstants.subscriptionEndPoint + p);
    log("${{
      "title": title,
      "subTitle": subTitle,
      "count": double.parse(count.toString()),
      "price": double.parse(price.toString()),
      // "validity": validity,
    }}");
    log("url : $uri");

    var response = await http.post(uri, body: {
      "title": title,
      "subTitle": subTitle,
      "count": count,
      "price": price,
      // "validity": validity,
    });

    if (response.statusCode == 200) {
      print("Successful");
    } else {
      print("HTTP request failed with status code ${response.statusCode}");
    }

    return (jsonDecode(response.body));
  }

  /// Get Subscription History from the server ///

  Future<List<SubscriptionHistoryModel>> getSubscription() async {
    var p = PrefService().getRegId();
    List<SubscriptionHistoryModel> myList = [];
    var data =
        await networkCalls.get(AppConstants.subscriptionHistoryEndPoint + p);
    for (var i in jsonDecode(data)) {
      log("var$i");
      myList.add(SubscriptionHistoryModel.fromJson(i));
    }
    return myList;
  }
}
