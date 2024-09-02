// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';
//
// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //initialising firebase message plugin
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   //function to initialise flutter local notification plugin to show notifications for android when app is active
//   void initLocalNotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosInitializationSettings = const DarwinInitializationSettings();
//
//     var initializationSetting = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);
//
//     await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
//         onDidReceiveNotificationResponse: (payload) {
//       handleNotification(context, message);
//     });
//   }
//
//   void firebaseInit(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((message) {
//       RemoteNotification? notification = message.notification;
//
//       if (kDebugMode) {
//         print("notifications title:${notification!.title}");
//         print("notifications body:${notification.body}");
//         print("notifications type:${message.data['type']}");
//         print("notifications id:${message.data['id']}");
//       }
//       if (Platform.isAndroid) {
//         initLocalNotifications(context, message);
//         showNotification(message);
//       } else {
//         showNotification(message);
//       }
//     });
//   }
//
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       if (kDebugMode) {
//         print('user granted permission');
//       }
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       if (kDebugMode) {
//         print('user granted provisional permission');
//       }
//     } else {
//       //appsetting.AppSettings.openNotificationSettings();
//       if (kDebugMode) {
//         print('user denied permission');
//       }
//     }
//   }
//
//   // function to show visible notification when app is active
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       message.notification!.android!.channelId.toString(),
//       message.notification!.android!.channelId.toString(),
//       importance: Importance.max,
//       showBadge: true,
//       playSound: true,
//     );
//
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       channelDescription: 'your channel description',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       ticker: 'ticker',
//       sound: channel.sound,
//     );
//
//     const DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//             presentAlert: true, presentBadge: true, presentSound: true);
//
//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);
//
//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         notificationDetails,
//       );
//     });
//   }
//
//   //function to get device token on which we will send the notifications
//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }
//
//   void isTokenRefresh() async {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       if (kDebugMode) {
//         print('refresh');
//       }
//     });
//   }
//
//   //handle Notification
//   void handleNotification(BuildContext context, RemoteMessage message) {
//     if (message.data['type'] == 'msj') {
//       Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return const NotiFicationScreen();
//         },
//       ));
//     }
//   }
//
//   // void sendNotification(deviceToken, String title, String body) async {
//   //   var data = {
//   //     'registration_ids':
//   //         deviceToken, // Use 'registration_ids' for multiple devices
//   //     'notification': {
//   //       'title': title,
//   //       'body': body,
//   //       'sound': 'jetsons_doorbell.mp3', // You can include sound if needed
//   //     },
//   //     'data': {'type': 'msj', 'id': 'Asif Taj'} // Additional data payload
//   //   };
//   //
//   //   try {
//   //     await http.post(
//   //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//   //       body: jsonEncode(data),
//   //       headers: {
//   //         'Content-Type': 'application/json; charset=UTF-8',
//   //         'Authorization':
//   //             'key=AAAAooDJnwI:APA91bGZUWgfEnGV379tFwGlbIgll_6-hY0UuoHarXHOYgnm7-qc1F9TFBmHcAPR3UAgFiG-rrkw-pZQj9m5eABroNKul3sczIPoUVgYAH4uNH6PQEPL8B-SRuRnreIBIxZQYtElXfFS'
//   //       },
//   //     );
//   //     print('Notification sent successfully to $deviceToken devices.');
//   //   } catch (e) {
//   //     print('Error sending notification: $e');
//   //   }
//   // }
// // Store Device token in firestore
//   Future<void> addUserDetails(user) async {
//     String? deviceToken = await FirebaseMessaging.instance.getToken();
//     await FirebaseFirestore.instance.collection('users').doc().set({
//       'Device Token': deviceToken,
//     });
//   }
// }
//
// void sendNotification(
//     List<String> deviceTokens, String title, String body) async {
//   var data = {
//     'registration_ids':
//         deviceTokens, // Use 'registration_ids' for multiple devices
//     'notification': {
//       'title': title,
//       'body': body,
//       'sound': 'jetsons_doorbell.mp3', // You can include sound if needed
//     },
//     'data': {'type': 'msj', 'id': 'Asif Taj'} // Additional data payload
//   };
//
//   try {
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       body: jsonEncode(data),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization':
//             'key=AAAAooDJnwI:APA91bGZUWgfEnGV379tFwGlbIgll_6-hY0UuoHarXHOYgnm7-qc1F9TFBmHcAPR3UAgFiG-rrkw-pZQj9m5eABroNKul3sczIPoUVgYAH4uNH6PQEPL8B-SRuRnreIBIxZQYtElXfFS'
//       },
//     );
//     print('Notification sent successfully to ${deviceTokens.length} devices.');
//   } catch (e) {
//     print('Error sending notification: $e');
//   }
// }
//
// final FirebaseAuth auth = FirebaseAuth.instance;
// Future<String> getAccessToken() async {
//   final serviceAccountJson = {};
//
//   List<String> scopes = [
//     "https://www.googleapis.com/auth/userinfo.email",
//     "https://www.googleapis.com/auth/firebase.database",
//     "https://www.googleapis.com/auth/firebase.messaging"
//   ];
//
//   http.Client client = await auth.clientViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
//
// //get the access token
//   auth.AccessCredentials credentials =
//       await auth.obtainAccessCredentialsViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//           scopes,
//           client);
//   client.close();
//   return credentials.accessToken.data;
// }
