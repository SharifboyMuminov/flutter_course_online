import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  print("Background notification clicked!");
  print("Payload: ${notificationResponse.payload}");
  // Qo‘shimcha ishlovlar
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService notificationService =
      NotificationService._();

  NotificationService._();

  factory NotificationService() {
    return notificationService;
  }

  static Future<void> initNotification() async {
    // Android uchun initialization
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(
      'flutter_logo',
    );

    // iOS uchun initialization
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // To‘liq initialization
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          backgroundNotificationHandler, // Top-level function
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // Ilova faol bo'lsa, bu yerda ishlov berish
        print("Notification clicked: ${notificationResponse.payload}");
      },
    );

    // iOS uchun permission so'rash
    await requestIOSNotificationPermission();

    // Android uchun permission so'rash
    await requestAndroidNotificationPermission();
  }

  // iOS permission
  static Future<void> requestIOSNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print("iOS notification permission granted!");
    } else {
      print("iOS notification permission denied.");
    }
  }

  // Android permission
  static Future<void> requestAndroidNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print("Android notification permission granted!");
      } else {
        print("Android notification permission denied.");
      }
    } else {
      print("Android notification permission already granted!");
    }
  }

  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    // Android uchun notification details (default sound)
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      icon: 'flutter_logo',
      importance: Importance.max,
    );

    // iOS uchun notification details (default sound)
    var iOSDetails = const DarwinNotificationDetails(
      sound: 'default', // iOS default sound
    );

    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  cancelAll() {
    notificationsPlugin.cancelAll();
  }
}
