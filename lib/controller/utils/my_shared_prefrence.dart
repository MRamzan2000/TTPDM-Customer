import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> reload() async {
    _preferences.reload();
  }

  static containKey(String key) {
    return _preferences.containsKey(key);
  }

  static setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? "";
  }

  static setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }
  static removeKey(String key) {
    return _preferences.remove(key) ;
  }
  Future<void> saveNotification(RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    // Create the notification JSON string
    String receivedTime = DateTime.now().toIso8601String();
    String notificationJson = json.encode({
      "title": message.notification?.title,
      "body": message.notification?.body,
      "data": message.data,
      "receivedTime": receivedTime,
    });

    log("New notification: $notificationJson");

    // Limit the number of notifications
    if (notifications.length >= 10) {
      notifications.removeAt(0); // Remove the oldest notification
    }

    // Add the new notification to the list
    notifications.add(notificationJson);
    log("Notifications count before saving: ${notifications.length}");

    // Store the updated notifications list
    await prefs.setStringList('notifications', notifications);
    log("Notifications count after saving: ${notifications.length}");
  }
  List<String> notifications=[];
  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    log("get notifications length: ${notifications.length}");

    List<Map<String, dynamic>> decodedNotifications = [];

    for (var notification in notifications) {
      String sanitizedNotification = escapeJsonString(notification);
      try {
        decodedNotifications.add(json.decode(sanitizedNotification) as Map<String, dynamic>);
      } catch (e) {
        log("Error decoding notification: $sanitizedNotification, error: $e");
      }
    }
    return decodedNotifications;
  }
  String escapeJsonString(String input) {
    return input.replaceAll(RegExp(r'[\r\n]', unicode: true), ' ');
  }
}
