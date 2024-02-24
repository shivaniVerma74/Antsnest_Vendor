import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/screen/bottom_bar.dart';
import 'package:fixerking/screen/push_notification_service.dart';
import 'package:fixerking/screen/splash_screen.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'token/token_string.dart';

class Fastsplash extends StatefulWidget {
  const Fastsplash({Key? key}) : super(key: key);

  @override
  State<Fastsplash> createState() => _FastsplashState();
}

class _FastsplashState extends State<Fastsplash> {
  String token = '';
  String? uid;

  @override
  void initState() {
    super.initState();
    getToken();
    checkingLogin();
    PushNotificationService notificationService = new PushNotificationService(context: context);
    notificationService.initialise();
  }

  getToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID=== $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: 'images/splash_one.png',
        backgroundColor: AppColor.PrimaryDark,
        nextScreen: uid == null || uid == "" ? SplashScreen() : BottomBar(),
        splashIconSize: 190.sp,
        duration: 350,
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
    });
  }
}
