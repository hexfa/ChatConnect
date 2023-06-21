import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static NotificationController get instance => NotificationController();

  Future takeFCMTokenWhenAppLaunch() async {
    try{
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );


      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      });
    }catch(e) {
      print(e);
    }
  }





  Future initLocalNotification() async{
    if (Platform.isIOS ) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
      AndroidInitializationSettings('icon_notification');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }else {
      var initializationSettingsAndroid = AndroidInitializationSettings('icon_notification');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }

  void _onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async { }

  void _selectNotification(String? payload) async { }


}