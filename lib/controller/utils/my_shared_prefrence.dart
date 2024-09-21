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

    String receivedTime = DateTime.now().toIso8601String();

    // Create a properly formatted notification JSON string
    String notificationJson = '''
    {
      "title": "${message.notification?.title}",
      "body": "${message.notification?.body}",
      "data": ${json.encode(message.data)},  
      "receivedTime": "$receivedTime"
    }
  ''';

    notifications.add(notificationJson);
    await prefs.setStringList('notifications', notifications);
  }

  List<String> notifications=[];
  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifications= prefs.getStringList('notifications') ?? [];
    log("notifications length:${notifications.length}");
    return notifications.map((notification) {
      return json.decode(notification) as Map<String, dynamic>; // Explicitly cast
    }).toList();
  }
}
