import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movies_app_task/core/constants/app_strings.dart';
import 'package:movies_app_task/core/network/api_strings.dart';
import 'package:movies_app_task/core/services/service_locator.dart';

class NotificationService {
  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    listenToFirebaseMessages(flutterLocalNotificationsPlugin);
  }

  Future<void> listenToFirebaseMessages(flutterLocalNotificationsPlugin) async {
    // listen to firebase messaging and then fire local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showNotification(message, flutterLocalNotificationsPlugin);
    });
  }

  // handle notifications
  void handleNotificationInForeground() {
    // only works if app in foreground
    // this function works automatically when the app is in foreground and receives a notification
    // so don't handle foreground notification clicks here
    // use onDidReceiveNotificationResponse() instead
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        log('notification title: ${message.notification?.title} notification body: ${message.notification?.body}',
            name: 'handleNotificationInForeground');
        log('this function works automatically when the app is in foreground and receives a notification,   so don\'t handle foreground notification clicks here, use onDidReceiveNotificationResponse() instead',
            name: 'handleNotificationInBackground');
      }
    });
  }

  void handleNotificationInBackground() {
    // only works if app in background but not terminated
    // this function calls when the user clicks on a notification when the app is in background
    // this function doesn't fire automatically when the app receives a notification
    // it requires the user to click on the notification to fire this function, so handle background notification clicks here
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        log('notification title: ${message.notification?.title} notification body: ${message.notification?.body}',
            name: 'handleNotificationInBackground');
        log('this function requires the user to click on the notification to fire this function, so handle background notification clicks here',
            name: 'handleNotificationInBackground');
      }
    });
  }

  void handleNotificationInTerminated() {
    // only works when app is terminated (first start)
    // this function calls when the user clicks on a notification when the app is terminated
    // this function doesn't fire automatically when the app receives a notification
    // it requires the user to click on the notification to fire this function, so handle terminated notification clicks here
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log('notification title: ${message.notification?.title} notification body: ${message.notification?.body}',
            name: 'handleNotificationInTerminated');
        log('this function requires the user to click on the notification to fire this function, so handle terminated notification clicks here',
            name: 'handleNotificationInTerminated');
      }
    });
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    // this function fires when the user clicks on a notification when the app is in foreground
    // use this function to handle clicks when the app is in foreground and the use clicks on a notification
    if (kDebugMode) {
      log('this function fires when the user clicks on a notification when the app is in foreground',
          name: 'onDidReceiveNotificationResponse');
    }
  }

  Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatContentTitle: true,
    );

    // setup Android local notification details
    String channelId = AppStrings.notificationChannelId;
    String channelName = AppStrings.notificationChannelName;

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    // assign Android and IOS notifications details to
    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );

    if (message.notification != null) {
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: message.data['body'],
      );
    }
  }

  Future<void> requestFCMPermissions() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            announcement: false,
            carPlay: false,
            criticalAlert: false,
            provisional: false);
    if (kDebugMode) {
      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        if (kDebugMode) {
          log('user granted auth', name: 'Request FCM permission status');
        }
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          log('user grant provisional permission',
              name: 'Request FCM permission status');
        }
      } else {
        if (kDebugMode) {
          log('user did not grant permission',
              name: 'Request FCM permission status');
        }
      }
    }
  }



  Future<String?> requestDeviceToken() async {
    try {
      String? deviceToken = '';
      deviceToken = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        deviceToken = fcmToken;
      });
      if (kDebugMode) {
        log('$deviceToken', name: 'fcm device token');
      }

      return deviceToken;
    } catch (error) {
      if (kDebugMode) {
        log('$error', name: 'requestDeviceToken error');
      }
      return null;
    }
  }

  Future<void> sendPushNotification(
      String title, String body, String token, String type) async {
    try {
      final dio = sl<Dio>();
      await dio.post(ApiStrings.fcmPath,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${ApiStrings.fcmServer}'
        }
      ), data: {
            'priority': 'high',
            // this is for clickable notification
            'data': <String, dynamic>{
              'click_action': AppStrings.flutterNotificationClickAction,
              'status': 'done',
              'type': type,
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              'type': type,
              "body": body,
              'android_channel_id': AppStrings.notificationChannelId
            },
            "to": token
          });
    } catch (error) {
      rethrow;
    }
  }
}
