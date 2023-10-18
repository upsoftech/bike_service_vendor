import 'dart:developer';

import 'package:bike_services_vendor/provider/banner_provider.dart';
import 'package:bike_services_vendor/provider/google_auth_provider.dart';
import 'package:bike_services_vendor/provider/order_provider.dart';
import 'package:bike_services_vendor/provider/pref_provider.dart';
import 'package:bike_services_vendor/provider/profile_provider.dart';
import 'package:bike_services_vendor/provider/subscription_history_provider.dart';
import 'package:bike_services_vendor/routes/app_route_config.dart';
import 'package:bike_services_vendor/services/notification_services.dart';
import 'package:bike_services_vendor/shared_preference/pref_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';



FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// FOR Initializing Shared Preference
  await PrefService.init();
  /// FOR Initializing Notification Service
  await NotificationService.init();

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
      defaultActionName: 'Open notification');
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
   bool ? initialized = await  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        log("Notification initialized Response: ${response}");

        var deviceState = await OneSignal.shared.getDeviceState();
        var deviceId = deviceState?.userId;
        // PrefService().setDeviceId(deviceId.toString());
        print("Device ID: $deviceId");
      });

   log("Notification initialized : ${initialized}");

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PrefProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSign()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(
            create: (context) => SubscriptionHistoryProvider()),
      ],
      child: MaterialApp.router(
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        title: 'Bike9Pro Partner',
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
      ),
    );
  }
}

void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
  log("onDidReceiveLocalNotification : $payload");

}
void onDidReceiveNotificationResponse(NotificationResponse details) {


  log("onDidReceiveNotificationResponse : $details");

}