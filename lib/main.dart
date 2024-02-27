import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/screen/push_notification_service.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'fast_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  changeStatusBarColor(AppColor().colorPrimary());
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: AppColor().colorPrimaryDark(), // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Antsnest Partner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        themeMode: ThemeMode.light,
        initialRoute: "/",
        // home: SplashScreen(),
        home: Fastsplash(),
      );
    });
  }
}
