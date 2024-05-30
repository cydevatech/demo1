import 'dart:io';
import 'dart:async';
import 'package:demo1/api/app_dependencies.dart';
import 'package:demo1/main.dart';
import 'package:demo1/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:demo1/storages/storage.dart';
import 'package:demo1/utils/services/notification/local_notification_service.dart';
import 'package:demo1/utils/services/notification_key/notification_key.dart';

@lazySingleton
class FCMService {
  final NotificationService notificationService = getIt<NotificationService>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final messageStream = FirebaseMessaging.onMessage;
  Future<void> init() async {
    await requestPermission();
    final token = await getToken();
    print('FCM Token: $token');
    await _initPushNotification();
  }

  void _handleInitialOrOpenedAppMessage(RemoteMessage? message) async {
    print('Data Noti ::::');
    if (message != null) {
      _handleMessage(message);
    }
  }

  void _handleMessage(RemoteMessage message) {
    print('Data Noti ::::');
    print(' Received message: ${message.notification}');
    print(' Received message: ${message.data}');
    if (message.data['screen'] != null) {
      _navigateToScreen(message.data['screen'], message.data['id']);
    } else if (message.notification != null) {
      _handleNotificationMessage(message.data['screen'], message.data['id']);
    }
  }

  void _handleNotificationMessage(String? screen, String? id) {
    switch (screen) {
      // case NotificationType.orderDetail:
      //   _navigateToTournamentDetail(id);
      //   break;

      default:
        _navigateToNoti();
    }
  }

  void _navigateToScreen(String? screen, String? id) {
    if (screen == null) return;
    switch (screen) {
      // case NotificationType.orderDetail:
      //   _navigateToTournamentDetail(id);
      //   break;

      default:
        _navigateToNoti();
    }
  }

  void _navigateToTournamentDetail(String? id) {
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
      RouterName.dashboardScreen,
      arguments: {'index': 0},
    );
  }

  void _navigateToNoti() {
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
      RouterName.dashboardScreen,
      arguments: {'index': 0},
    );
  }

  void _handleNotificationTap(Map<String, dynamic> message) {
    print('Data Noti :::: ${message}');
    String? screen = message['data']['screen'];
    String? id = message['data']['id'];
    if (screen != null && id != null) {
      _navigateToScreen(screen, id);
    }
  }

  Future<void> _initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('Data Noti ::::1 ${message}');
        // _handleNotificationTap(message.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Data Noti ::::2 ${message.data['id']}');
      // _handleNotificationTap(message.data);
      // await Navigator.of(navigatorKey.currentContext!).pushNamed(
      //     RouterName.orderDetail,
      //     arguments: int.tryParse(message.data['id']));
    });

    FirebaseMessaging.onMessage.listen(_onForeground);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  @pragma("vm:prefer-inline")
  Future<void> _handleBackgroundMessage(RemoteMessage? message) async {
    print('Data Noti :::: 3${message?.data}');
    print('Handling a background message ${message?.notification?.title}');
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
      RouterName.dashboardScreen,
      arguments: {'index': 0},
    );
    Timer(const Duration(milliseconds: 1000), () async {
      // await Navigator.of(navigatorKey.currentContext!).pushNamed(
      //     RouterName.orderDetail,
      //     arguments: int.tryParse(message?.data['id']));
    });
  }

  Future<void> _onForeground(RemoteMessage? event) async {
    print('Handling a foreground message ${event?.data['id']}');

    if (event == null) return;
    final map = event.notification!;
    await notificationService.showNotification(
        id: 0, title: map.title!, body: map.body!);
  }

  Future<String?> getToken() async {
    String? token;
    if (Platform.isIOS) {
      print('getAPNSToken:ios $token');
      await Future<void>.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      token = await FirebaseMessaging.instance.getAPNSToken();
      token = await FirebaseMessaging.instance.getToken();
      print('getAPNSToken:ios $token');
    } else {
      token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        token = await FirebaseMessaging.instance.getToken();
      }
    }
    print('getAPNSToken: app $token');
    return token;
  }

  Future<void> sendTokenToServer() async {}

  Future<AuthorizationStatus> requestPermission() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    return settings.authorizationStatus;
  }

  void changeToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      print('Token refreshed: $token');
    });
  }
}
