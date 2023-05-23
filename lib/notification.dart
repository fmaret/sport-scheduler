import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';


class Notification{
  static Future initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Paris"));

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              criticalAlerts: true,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true
    );
  }

  static Future sendNotification({var id =0,required String title, required String body,
    var payload
  } ) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            actionType: ActionType.KeepOnTop,
            category: NotificationCategory.Call
        ),
        actionButtons: [
          NotificationActionButton(key: "key", label: "label", actionType: ActionType.DismissAction)
        ],
        // schedule: NotificationCalendar.fromDate(date: DateTime.now().add(const Duration(seconds: 5)))

    );

  }

  // static Future scheduleNotification({required String title, required String body}) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       title,
  //       body,
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
  //       NotificationDetails(
  //           android: getAndroidNotificationDetails(title: "testScheduled", channelName: "test")
  //           ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime);
  //
  // }
  //
  // static Future schedulePeriodicNotification({required String title, required String body}) async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //   getAndroidNotificationDetails(title: "testPeriodicScheduled", channelName: "test");
  //   NotificationDetails notificationDetails =
  //   NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(0, title,
  //       body, RepeatInterval.everyMinute, notificationDetails,
  //       androidAllowWhileIdle: true);
  //
  //
  // }



}
