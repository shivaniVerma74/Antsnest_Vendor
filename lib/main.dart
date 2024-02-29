import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/fcm_helper.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'fast_splash.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FCMHelper.shared.listenNotificationInBackground(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FCMHelper.shared.intializeFirebase();
  changeStatusBarColor(AppColor().colorPrimary());
  // FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: AppColor().colorPrimaryDark(), // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _handleMessage(RemoteMessage message) {
    print("_handleMessage : ${message.data}");
  }

  @override
  void initState() {
    super.initState();
    firebaseSetup();
  }

  firebaseSetup() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.data}');
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });
  }

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
