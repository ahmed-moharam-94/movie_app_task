import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movies_app_task/core/router/app_router.dart';
import 'package:movies_app_task/core/services/notification_service.dart';
import 'package:movies_app_task/core/theme/app_theme.dart';
import 'constants/app_strings.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    NotificationService().requestFCMPermissions();
    NotificationService().initNotification(flutterLocalNotificationsPlugin);
    NotificationService().handleNotificationInForeground();
    NotificationService().handleNotificationInBackground();
    NotificationService().handleNotificationInTerminated();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}