import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class Notification{

  static getAndroidNotificationDetails({
    required String title,
    required String channelName,
    String? description = "",
    bool playSound = false,
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }){
    return AndroidNotificationDetails(
      title,
      channelName,
      channelDescription: description,
      playSound: playSound,
      //sound: RawResourceAndroidNotificationSound('notification'),
      importance: importance,
      priority: priority,
    );
  }

  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));
    var status = await Permission.notification.request();
    var androidInitialize = const AndroidInitializationSettings('duck');
    var initializationsSettings = InitializationSettings(android: androidInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
  }

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  } ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        getAndroidNotificationDetails(title: "test", channelName: "test");
    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
    );
    await fln.show(0, title, body,not );
  }

  static Future scheduleNotification({required String title, required String body}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
        NotificationDetails(
            android: getAndroidNotificationDetails(title: "testScheduled", channelName: "test")
            ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }

  static Future schedulePeriodicNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
    getAndroidNotificationDetails(title: "testPeriodicScheduled", channelName: "test");
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, title,
        body, RepeatInterval.everyMinute, notificationDetails,
        androidAllowWhileIdle: true);


  }



}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
