import 'dart:async';

import 'package:demo1/storages/storage.dart';
import 'package:flutter/material.dart';
import 'package:demo1/api/app_dependencies.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/routers/routes.dart';
import 'package:demo1/storages/storage.dart';
import 'package:demo1/utils/services/notification/fcm_service.dart';
import 'package:demo1/utils/services/notification/local_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // setUpNotification();
    startTimer();
    final token = getIt<HiveStorage>().token;
    print('token: $token');
  }

  Future<void> setUpNotification() async {
    await getIt<NotificationService>().init();
    await getIt<FCMService>().init();
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacementNamed(
        RouterName.loginScreen,
        // arguments: {'index': 0},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: 70.sp),
            child: ClipOval(
                // child: ImageAssets.pngAsset(
                //   Png.imgLogo,
                //   width: 160.sp,
                //   circle: true,
                // ),
                ),
          ),
        ),
      ),
    );
  }
}
