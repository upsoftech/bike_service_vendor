import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes_constant.dart';
import '../../utils/image.dart';
import '../provider/pref_provider.dart';
import '../services/notification_services.dart';
import '../shared_preference/pref_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final prefProvider = Provider.of<PrefProvider>(context, listen: false);
    prefProvider.getRegId();
    prefProvider.getUserSession();

    checkSession();
  }

  checkSession() async {
    var p = PrefService();
    var session = p.getUserSession();
    var regId = p.getRegId();
    log("redId : $regId");
    log("Splash2 : $session");
    OneSignal.shared.setAppId("6c1222ad-6282-410e-9703-c51495fbcbc8");

    var deviceState = await OneSignal.shared.getDeviceState();
    var deviceId = deviceState!.userId;
    if (deviceId == null) {
      // Device ID is null, retry after a delay
      await Future.delayed(const Duration(seconds: 2)); // Adjust the delay as needed
      deviceState = await OneSignal.shared.getDeviceState();
      deviceId = deviceState?.userId;
    }
    print("Device ID Splash: $deviceId");
    PrefService().setDeviceId(deviceId.toString());
    if (session == true && regId != "" && regId !=null) {
      _navigethome();
    } else {
      _navigeteLogin();
    }
  }

  _navigethome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    GoRouter.of(context).pushNamed(AppConstantRoute.dashboardRoute);
  }

  _navigeteLogin() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    // ignore: use_build_context_synchronously
    GoRouter.of(context).pushNamed(AppConstantRoute.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppImage.appLogo,
          ),
        ),
      ),
    ));
  }
}
