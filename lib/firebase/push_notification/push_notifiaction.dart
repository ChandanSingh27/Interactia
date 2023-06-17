
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:taskhub/firebase/push_notification/show_notification.dart';


Future<void> onBackgroundMessageHandler(RemoteMessage message) async{
  ShowNotification.sendNotification(message);
}

class PushNotification {

  static Future<void> init() async {

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    ShowNotification.init();

    if(settings.authorizationStatus == AuthorizationStatus.authorized){


      FirebaseMessaging.onMessage.listen((message) {
        ShowNotification.sendNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
      });

      FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);

    }else{
        AppSettings.openNotificationSettings();
    }
  }



  static Future<void> getInitialMessage() async{
    // RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  }

  static Future<String?> getToken() async{
    return await FirebaseMessaging.instance.getToken();
  }
}