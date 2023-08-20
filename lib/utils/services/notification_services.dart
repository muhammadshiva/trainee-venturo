import 'dart:convert';

import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationServices {
  NotificationServices._();

  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String notifImage = 'app_icon';
  static const String notifChannelId = 'default_notification_channel_id';
  static const String notifChannelName = 'default_notification_channel_name';
  static const String notifChanelDesc = 'default_notification_channel_desc';

  static const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings(notifImage),
  );

  static const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      notifChannelId,
      notifChannelName,
      channelDescription: notifChanelDesc,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      color: AppColor.blueColor,
    ),
  );

  static Future<void> init() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
          const AndroidNotificationChannel(
            notifChannelId,
            notifChannelName,
            description: notifChanelDesc, // description,
            importance: Importance.max,
          ),
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          final data = json.decode(payload);

          if (data['id_promo'] != null) {
            /// Mendapatkan user dan token dari local DB service
            var user = await LocalDBServices.getUser();
            var token = await LocalDBServices.getToken();

            if (user != null && token != null) {
              DashboardController.to.tabIndex.value = 0;

              /// Navigasi ke detail promo jika sudah login
              await Get.offNamedUntil(
                AppRoutes.detailPromoView,
                ModalRoute.withName(AppRoutes.dashboardView),
                arguments: int.parse(data['id_promo'].toString()),
              );
            }
          } else if (data['id_order'] != null) {
            /// Mendapatkan user dan token dari local DB service
            var user = await LocalDBServices.getUser();
            var token = await LocalDBServices.getToken();

            if (user != null && token != null) {
              DashboardController.to.tabIndex.value = 1;

              /// Navigasi ke detail promo jika sudah login
              await Get.offNamedUntil(
                AppRoutes.detailOrderView,
                ModalRoute.withName(AppRoutes.dashboardView),
                arguments: int.parse(data['id_order'].toString()),
              );
            }
          }
        }
      },
    );

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(listen);
      FirebaseMessaging.onBackgroundMessage(listenBackground);
    }
  }

  static void listen(RemoteMessage message) {
    onMessageHandler(message);
  }

  static Future<void> listenBackground(RemoteMessage message) async {
    onMessageHandler(message);
  }

  static Future<void> onMessageHandler(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }

  static Future<void> sendNotification(String title, String body, Map<String, dynamic> data) async {
    /// Cek FCM token
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) return;

    /// Kirim notifikasi
    await ApiServices.dioCall(
      authorization: 'key=${AppConst.firebaseCloudMessagingKey}',
    ).post(
      ApiConst.firebaseCloudMessaging,
      data: {
        'notification': {'title': title, 'body': body},
        'priority': 'high',
        'data': data,
        'to': fcmToken,
      },
    );
  }
}

// import 'dart:developer';

// import 'package:coffee_app/configs/routes/app_routes.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/route_manager.dart';

// class FirebaseMessagingService {
//   static FirebaseMessaging instance = FirebaseMessaging.instance;
//   static FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     // init notif channel
//     const channel = AndroidNotificationChannel(
//       'order_notification_channel',
//       'order channel',
//       description: 'order data channel',
//       importance: Importance.high,
//     );

//     // init local notif
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//     );

//     await localNotification.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );

//     // create init channel
//     await localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

//     // request permission
//     await localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

//     // listen to foreground notif
//     FirebaseMessaging.onMessage.listen(
//       (message) async {
//         //show notification
//         print('onMessage: $message');
//         await FirebaseMessagingService.handleNotif(message);
//       },
//       onError: (e) {
//         print(e);
//       },
//     );
//   }

//   @pragma('vm:entry-point')
//   static Future<void> handleNotif(RemoteMessage message) async {
//     print("Foreground ${message.data}");
//     // get remote message data
//     final notificationData = message.notification;

//     final androidNotifDetail = AndroidNotificationDetails('order_notification_channel', 'order channel',
//         channelDescription: 'order data channel', icon: notificationData?.android?.smallIcon, priority: Priority.high);

//     final NotificationDetails notifDetail = NotificationDetails(
//       android: androidNotifDetail,
//     );

//     if (notificationData != null) {
//       localNotification.show(
//         notificationData.hashCode,
//         notificationData.title,
//         notificationData.body,
//         notifDetail,
//         payload: message.data['id_order'],
//       );
//     }
//   }

//   @pragma('vm:entry-point')
//   static Future<void> handleBackgroundNotif(RemoteMessage message) async {
//     print("Background ${message.data}");

//     // get remote message data
//     final notificationData = message.notification;

//     final androidNotifDetail = AndroidNotificationDetails('order_notification_channel', 'order channel',
//         channelDescription: 'order data channel', icon: notificationData?.android?.smallIcon, priority: Priority.high);

//     const darwinNotifDetail = DarwinNotificationDetails();

//     final NotificationDetails notifDetail = NotificationDetails(
//       android: androidNotifDetail,
//       iOS: darwinNotifDetail,
//     );

//     if (notificationData != null) {
//       localNotification.show(
//         notificationData.hashCode,
//         notificationData.title,
//         notificationData.body,
//         notifDetail,
//         payload: message.data['id_order'],
//       );
//     }
//   }

//   void onDidReceiveNotificationResponse(NotificationResponse response) {
//     // handle notif payload when user click the notification item
//     print("payload ${response.payload}");
//     if (response.payload != null) {
//       final idOrder = int.parse(response.payload!);
//       Get.toNamed(AppRoutes.detailOrderView);
//     }
//   }
// }
