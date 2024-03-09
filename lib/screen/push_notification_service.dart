import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> backgroundMessage(RemoteMessage message) async {
  print(message);
}

String fcmToken = "";

// class PushNotificationService {
//   late BuildContext context;

//   PushNotificationService({required this.context});
void iOSPermission() async {
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<String> _downloadAndSaveImage(String url, String fileName) async {
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await http.get(Uri.parse(url));

  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> generateImageNotication(
    String title, String msg, String image, String type, String id) async {
  var largeIconPath = await _downloadAndSaveImage(image, 'largeIcon');
  var bigPicturePath = await _downloadAndSaveImage(image, 'bigPicture');
  var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: msg,
      htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 'big text channel name',
      channelDescription: 'big text channel description',
      icon: '@mipmap/ic_launcher',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: bigPictureStyleInformation);
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, msg, platformChannelSpecifics, payload: type + "," + id);
}

Future<void> generateSimpleNotication(
    String title, String msg, String type, String id) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      channelDescription: 'your channel description',
      importance: Importance.max,
      icon: '@mipmap/ic_launcher',
      priority: Priority.high,
      ticker: 'ticker');
  var iosDetail = DarwinNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosDetail);
  await flutterLocalNotificationsPlugin
      .show(0, title, msg, platformChannelSpecifics, payload: type + "," + id);
}

Future initialise() async {
  iOSPermission();
  messaging.getToken().then((token) async {
    fcmToken = token.toString();
    print("fcmToken---" + fcmToken);
  });
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String? payload) async {

  //     });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("0k Push Notification======" + message.toString());
    var data = message.notification!;
    print("cehed====" + data.toString());
    var title = data.title.toString();
    var body = data.body.toString();
    var image = message.data['image'] ?? '';
    print("check" + image);
    var type = message.data['type'] ?? '';
    var id = '';
    id = message.data['type_id'] ?? '';
    if (image != null && image != 'null' && image != '') {
      generateImageNotication(title, body, image, type, id);
    } else {
      generateSimpleNotication(title, body, type, id);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  });

// Future<dynamic> myForgroundMessageHandler(RemoteMessage message) async {
//   return Future<void>.value();
// }
}
