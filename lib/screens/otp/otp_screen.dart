import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../routes/app_routes_constant.dart';
import '../../../utils/app_dimension.dart';
import '../../../utils/app_style.dart';
import '../../../utils/image.dart';
import '../../customWidget/custom_button.dart';

import '../../dashboard/dashboard.dart';
import '../../services/api_services.dart';
import '../../shared_preference/pref_services.dart';
import '../../utils/color.dart';
import '../login_page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.number, required this.otp}) : super(key: key);
  final String number;
  final String otp;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}


final ApiServices _apiService = ApiServices();
final FirebaseAuth auth=FirebaseAuth.instance;
var code="";
final TextEditingController pinController = TextEditingController();
final PrefService _prefService = PrefService();

class _OtpScreenState extends State<OtpScreen> {
  final focusNode = FocusNode();
  final focusedBorderColor = AppColor.btnColor;
  final fillColor = AppColor.textWhite;
  final borderColor = AppColor.btnColor;

  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: textStyle,
      decoration: decorationBorder);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinController.text = widget.otp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: CustomButton(
          onTapPress: ()  {

            // PhoneAuthCredential credential=PhoneAuthProvider.credential(
            //     verificationId: LoginScreen.verify, smsCode: pinController.text.trim());
            // await auth.signInWithCredential(credential);
            _apiService
                .verifyOtp(
              widget.number,
              widget.otp,
            )
                .then((value) async {
              log("Check$value");
              _prefService.setRegId(value["data"]["_id"]);

            });
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashBoardScreen()),
            );

          },
          textButton: 'Continue',
          style: appbarStyle,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              AppImage.otp,
              height: AppDimension.height(context) * .4,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Enter the four digit code send to your mobile Number.",
                style: h1Style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
              child: Center(
                  child: Pinput(
                    length: 4,
                controller: pinController,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              )),
            ),
          ],
        ),
      )),
    );
  }
}
