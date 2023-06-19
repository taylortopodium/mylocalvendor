import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FireBaseMessagingService extends GetxService {

  Future<FireBaseMessagingService> init() async {
    FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true);
    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await fcmOnMessageListeners();
    FirebaseMessaging.instance
        .getToken()
        .then((value) => print("Firebase Messaging token is $value"));
    return this;
  }

  Future<void> setDeviceToken() async {
        FirebaseMessaging.instance.getToken().then((value) {
          print('Token is $value');
        });
  }


  Future fcmOnMessageListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      if (message.data['id'] == "App\\Notifications\\NewMessage") {
        _newMessageNotification(message);
      } else {
        _bookingNotification(message);
      }
    });
  }

  Future fcmOnLaunchListeners() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _notificationsBackground(message);
    }
  }

  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationsBackground(message);
    });
  }

  void _notificationsBackground(RemoteMessage message) {
    if (message.data['id'] == "App\\Notifications\\NewMessage") {
      _newMessageNotificationBackground(message);
    } else {
      _newBookingNotificationBackground(message);
    }
  }

  void _newBookingNotificationBackground(message) {

  }

  void _newMessageNotificationBackground(RemoteMessage message) {

  }



  void _bookingNotification(RemoteMessage message) {

  }

  void _newMessageNotification(RemoteMessage message) {

  }










}
