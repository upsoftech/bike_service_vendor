import 'dart:developer';

import 'package:bike_services_vendor/services/ring_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../main.dart';

class NotificationService {
  static Future<void> init() async {
    //Remove this method to stop OneSignal Debugging
    // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.shared
        .setAppId("6c1222ad-6282-410e-9703-c51495fbcbc8")
        .then((value) async {
      var deviceState = await OneSignal.shared.getDeviceState();
      var deviceId = deviceState?.userId;
      // PrefService().setDeviceId(deviceId.toString());
      print("Device ID: $deviceId");
      if (deviceId != null) {
        print("Device ID: $deviceId");
      } else {
        print("Device ID not available");
      }
    });

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    //  OneSignal.Notifications.requestPermission(true);
    //
    //  final status = OneSignal.User.toString();

    var deviceState = await OneSignal.shared.getDeviceState();
    var deviceId = deviceState?.userId;
    // PrefService().setDeviceId(deviceId.toString());
    print("Device ID: $deviceId");
    if (deviceId != null) {
      print("Device ID: $deviceId");
    } else {
      print("Device ID not available");
    }
    // OneSignal.User.pushSubscription.addObserver((state) {
    //   OSPushSubscriptionChangedState current = state.current as OSPushSubscriptionChangedState;
    //   OSPushSubscriptionChangedState previous = state.previous as OSPushSubscriptionChangedState;
    //   log("User Df${state.current}");
    //   if (state.current.optedIn) {
    //     /// Respond to new state
    //   }
    // });

    // final playerId = status.subscriptionStatus.userId;

    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      /// preventDefault to not display the notification

      log("New Event : ${event.notification.body}");
      if (event.notification.body
          .toString()
          .trim()
          .toLowerCase()
          .contains("new order")) {
        RingService.playSirenSound();
        showLocalNotification(
            "new order", "new order", {"new order": "new order"});
      }
    });
  }

  static Future<void> showLocalNotification(
      String title, String body, Map<String, dynamic> mapData) async {


    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "com.bike_service#push-notification-channel-id",
            "com.bike_service#push-notification-channel-name",
            priority: Priority.max,
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound("ring")
            // sound:  UriAndroidNotificationSound("assets/audios/ring.mp3"),
            );
    log("Ring : ${const RawResourceAndroidNotificationSound("ring").sound}");
    log("Ring : ${androidDetails.playSound}");
    RingService.playSirenSound();
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    flutterLocalNotificationsPlugin.show(1, title, body, notificationDetails);
  }
}
