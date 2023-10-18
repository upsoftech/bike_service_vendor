import 'dart:developer';

import 'package:bike_services_vendor/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes_constant.dart';
import '../../utils/app_dimension.dart';
import '../../utils/app_style.dart';
import '../../utils/color.dart';
import '../../utils/image.dart';
import '../provider/google_auth_provider.dart';
import '../services/api_services.dart';
import '../shared_preference/pref_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
    Provider.of<GoogleSign>(context, listen: false);
  }

  final ApiServices _apiService = ApiServices();
  final PrefService _prefService = PrefService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final googleProvider = Provider.of<GoogleSign>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            // TextButton(
            //     onPressed: () {
            //       NotificationService.showLocalNotification(
            //           "new order", "new order", {"new order": "new order"});
            //     },
            //     child: Text("Check")),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.appLogo,
                height: 100,
                width: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              child: const Text(
                "Enter Your Mobile Number",
                style: h1Style,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.only(left: 15),
              height: 55,
              decoration: decorationBorder,
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: TextField(
                      readOnly: true,
                      controller: countryCode,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(color: AppColor.grey, fontSize: 33),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    onChanged: (value) {
                      phone = value;
                    },
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.btnColor,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Phone Number"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: AppDimension.height(context) * .03,
            ),
            GestureDetector(
              onTap: () {
                if (mobileController.text.trim() != "" &&
                    mobileController.text.trim().length == 10) {
                  _apiService
                      .logInMb(mobileController.text.trim())
                      .then((value) async {
                    log("SMS_OTP : $value");
                    _prefService.setRegId(value["reg_id"].toString());
                    _prefService.setMobile(mobileController.text.trim());
                    _prefService.setUserSession(true);

                    //  sharedPreferences.setString('mobile', mobileController.text);
                    Fluttertoast.showToast(msg: "OTP Is ${value["otp"]}");

                    // await FirebaseAuth.instance.verifyPhoneNumber(
                    //   phoneNumber:countryCode.text.toString()+phone,
                    //   verificationCompleted:(PhoneAuthCredential credential){},
                    //   verificationFailed:(FirebaseAuthException e){},
                    //  codeSent: (String verificationId, int? forceResendingToken) {
                    //
                    //    log("SMS_OTP : $verificationId");
                    //    LoginScreen.verify=verificationId;
                    //     GoRouter.of(context).pushNamed(
                    //   AppConstantRoute.otpRoute,
                    //   extra: {
                    //     "mobile":mobileController.text.trim(),
                    //     "otp":value["otp"].toString()
                    //   },
                    // );  },
                    //     codeAutoRetrievalTimeout: (String verificationId) {  }
                    // );
                    GoRouter.of(context).pushNamed(AppConstantRoute.otpRoute,
                        extra: {
                          "mobile": mobileController.text.trim(),
                          "otp": value["otp"].toString()
                        });
                  });
                } else {
                  Fluttertoast.showToast(msg: "Please enter correct number");
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                decoration: decoration,
                child: const Text(
                  "Continue",
                  style: appbarStyle,
                ),
              ),
            ),
            SizedBox(
              height: AppDimension.height(context) * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
                const Text("OR"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                decoration:
                    decoration.copyWith(color: AppColor.grey.withOpacity(.2)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Continue With Facebook', style: h1Style)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                _prefService.setUserSession(true);
                googleProvider.googleLogin().then((value) => {
                      GoRouter.of(context)
                          .pushNamed(AppConstantRoute.dashboardRoute)
                    });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                decoration:
                    decoration.copyWith(color: AppColor.grey.withOpacity(.2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.google,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Continue With Google',
                      style: h1Style,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                width: double.infinity,
                decoration:
                    decoration.copyWith(color: AppColor.grey.withOpacity(.2)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apple_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Continue With Apple',
                      style: h1Style,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
