      import 'dart:io';
      import 'package:device_info_plus/device_info_plus.dart';
      import 'package:firebase_core/firebase_core.dart';
      import 'package:firebase_messaging/firebase_messaging.dart';
      import 'package:flutter/material.dart';
      import 'package:flutter_local_notifications/flutter_local_notifications.dart';
      import 'package:fluttertvtor/models/requests/notificationmodel.dart';
      import 'package:fluttertvtor/slelect_tutor_screen.dart';
      import '../rest/network_util.dart';
      import 'SharedPrefHelper.dart';

      // Update your pubspec.yaml first:
      // firebase_messaging: ^14.7.10
      // firebase_core: ^2.24.2
      // flutter_local_notifications: ^16.3.0
      // device_info_plus: ^9.1.1

      @pragma('vm:entry-point')
      Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        await Firebase.initializeApp();
        print('Handling a background message: ${message.messageId}');
      }

      class PushNotificationsManager {
        PushNotificationsManager._();

        static BuildContext? _context;

        factory PushNotificationsManager(BuildContext context) {
          _context = context;
          return _instance;
        }

        static final PushNotificationsManager _instance =
            PushNotificationsManager._();

        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
        final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        bool _initialized = false;

        Future<void> init() async {
          if (_initialized) return;

          print("Init called");

          NotificationSettings settings = await _firebaseMessaging.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            provisional: false,
            criticalAlert: true,
            announcement: false,
            carPlay: false,
          );

          print('User granted permission: ${settings.authorizationStatus}');

          // Create notification channel for Android
          if (Platform.isAndroid) {
            const AndroidNotificationChannel channel = AndroidNotificationChannel(
              'tvtor_notifications',
              'Tutor Notifications',
              description: 'This channel is used for important notifications.',
              sound: RawResourceAndroidNotificationSound('tvtor_notification_sound'),
              importance: Importance.max,
              playSound: true,
              enableVibration: true,
            );

            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.createNotificationChannel(channel);

            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestNotificationsPermission();
          }

          // Initialize local notifications
          const AndroidInitializationSettings androidInitSettings =
              AndroidInitializationSettings('ic_launcher');

          final DarwinInitializationSettings iosInitSettings =
              DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

          final InitializationSettings initializationSettings =
              InitializationSettings(
            android: androidInitSettings,
            iOS: iosInitSettings,
          );

          await _flutterLocalNotificationsPlugin.initialize(
            initializationSettings,
            onDidReceiveNotificationResponse: (NotificationResponse response) {
              final String? payload = response.payload;
              if (payload != null && _context != null) {
                Navigator.of(_context!).push(
                  MaterialPageRoute(
                    builder: (_) => SelectTutorScreen(nId: payload),
                  ),
                );
              }
            },
          );

          // Request Firebase permission

          // Handle initial message
          RemoteMessage? initialMessage =
              await _firebaseMessaging.getInitialMessage();
          if (initialMessage != null && _context != null) {
            _handleMessage(initialMessage);
          }

          // Handle foreground messages
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            print('onMessage: ${message.messageId}');
            print('Foreground message received: ${message.messageId}');
            print('Message data: ${message.data}');
            print('Notification: ${message.notification?.title} - ${message.notification?.android?.sound}');
            _showLocalNotification(message);
          });

          // Handle background messages when app is opened
          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            print('onMessageOpenedApp: ${message.messageId}');
            print('Foreground message received: ${message.messageId}');
            print('Message data: ${message.data}');
            print('Notification: ${message.notification?.title} - ${message.notification?.body}');
            _handleMessage(message);
          });

          // Get FCM token
         await refreshAndSendFcmToken();

          // Subscribe to token refresh
          _firebaseMessaging.onTokenRefresh.listen((String token) {
            SharedPrefHelper().save("firebasetoken", token);
            _sendDeviceInfoAndToken();
          });

          _initialized = true;
        }
        Future<void> refreshAndSendFcmToken() async {
          try {
            String? token = await _firebaseMessaging.getToken();
            if (token != null) {
              await SharedPrefHelper().save("firebasetoken", token);
              print("Refreshed Firebase token: $token");
              await _sendDeviceInfoAndToken();
            }
          } catch (e) {
            print("Error refreshing FCM token: $e");
          }
        }

        Future<void>  _sendDeviceInfoAndToken() async {
          try {
            String token =
                await SharedPrefHelper().getWithDefault("firebasetoken", "null");
            final deviceInfo = DeviceInfoPlugin();

            String deviceName = "";
            String deviceVersion = "";
            String identifier = "";

            if (Platform.isAndroid) {
              final androidInfo = await deviceInfo.androidInfo;
              deviceName = androidInfo.model;
              deviceVersion = androidInfo.version.release;
              identifier = androidInfo.id ?? '';
              print("Identifier: $identifier");
            } else if (Platform.isIOS) {
              final iosInfo = await deviceInfo.iosInfo;
              deviceName = iosInfo.name;
              deviceVersion = iosInfo.systemVersion;
              identifier = iosInfo.identifierForVendor ?? '';
            }

            String authToken = await SharedPrefHelper()
                .getWithDefault(SharedPrefHelper.token, "null");
            String managerId = await SharedPrefHelper()
                .getWithDefault(SharedPrefHelper.managerId, "");
            print("ManagerId:$managerId" );

            var response = await NetworkUtil().post(
              url: "fcmdevices",
              body: NotificationRequest(
                tmId: managerId,
                deviceId: identifier,
                deviceToken: token,
                deviceType: Platform.isAndroid ? "Android" : "iOS",
              ),
              token: authToken,
            );

            if (response != null) {
              print("Device registration response: $response");
            }
          } catch (e) {
            print("Error sending device info and token: $e");
          }
        }

        void _handleMessage(RemoteMessage message) {
          if (_context == null) return;

          String? notificationId = message.data['notificationId'];
          if (notificationId != null) {
            Navigator.of(_context!).push(
              MaterialPageRoute(
                builder: (_) => SelectTutorScreen(nId: notificationId),
              ),
            );
          }
        }

        Future<void> _showLocalNotification(RemoteMessage message) async {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null) {
            AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
              sound: RawResourceAndroidNotificationSound('tvtor_notification_sound'),
              'tvtor_notifications',
              'Tutor Notifications',
              channelDescription: 'This channel is used for important notifications.',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              enableVibration: true,
              styleInformation: BigTextStyleInformation(notification.body ?? ''),
            );

            DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            );

            NotificationDetails platformDetails = NotificationDetails(
              android: androidDetails,
              iOS: iosDetails,
            );

            await _flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              platformDetails,
              payload: message.data['notificationId'],
            );
          }
        }
      }
