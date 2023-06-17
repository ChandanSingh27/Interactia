import 'dart:math';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ShowNotification {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<String> downloadImage(String url,String fileName) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.jpg';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> init() async{
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings("mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(RemoteMessage message) async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(Random.secure().nextInt(100).toString(), "firebase_message_vs",importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name,importance: Importance.max,priority: Priority.high,ticker: "ticker");

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, notificationDetails);
  }

  static Future<void> showNotificationWithImage(RemoteMessage message) async{
    
    final imagePath = await downloadImage(message.notification?.android?.imageUrl as String,"image");

    AndroidNotificationChannel channel = AndroidNotificationChannel(Random.secure().nextInt(100).toString(), "firebase_message_vs",importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name,importance: Importance.max,priority: Priority.high,ticker: "ticker",styleInformation: BigPictureStyleInformation(
      FilePathAndroidBitmap(imagePath),
    ));

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, notificationDetails);
  }

  static Future<void> showNotificationWithImageAndIcon(RemoteMessage message) async{

    final imagePath = await downloadImage(message.notification?.android?.imageUrl as String,"image");
    final iconPath = await downloadImage(message.data["icon"] as String,"icon");

    AndroidNotificationChannel channel = AndroidNotificationChannel(Random.secure().nextInt(100).toString(), "firebase_message_vs",importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name,importance: Importance.max,priority: Priority.high,ticker: "ticker",styleInformation: BigPictureStyleInformation(
      FilePathAndroidBitmap(imagePath),
      largeIcon: FilePathAndroidBitmap(iconPath),
    ));

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, notificationDetails);
  }

  static Future<void> showNotificationWithIcon(RemoteMessage message) async{


    final imagePath = await downloadImage(message.data['icon'] as String,"icon");

    AndroidNotificationChannel channel = AndroidNotificationChannel(Random.secure().nextInt(100).toString(), "firebase_message_vs",importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id, channel.name,importance: Importance.max,priority: Priority.high,ticker: "ticker",largeIcon: FilePathAndroidBitmap(imagePath));

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, notificationDetails);
  }

  static Future<void> sendNotification(RemoteMessage message) async{

    if(message.notification?.android?.imageUrl != null && message.data['icon'] != null) {
      showNotificationWithImageAndIcon(message);
    }else if(message.notification?.android?.imageUrl != null){
      showNotificationWithImage(message);
    }else if(message.data['icon'] != null){
      showNotificationWithIcon(message);
    }else{
      showNotification(message);
    }
  }



}