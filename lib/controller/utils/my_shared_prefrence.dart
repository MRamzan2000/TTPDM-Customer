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

  // New methods for int
  static setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  static int getInt(String key) {
    return _preferences.getInt(key) ?? 0;
  }

  static removeKey(String key) {
    return _preferences.remove(key);
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

  List<String> notifications = [];

  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    log("notifications length: ${notifications.length}");

    List<Map<String, dynamic>> decodedNotifications = [];

    for (var notification in notifications) {
      // Escape any problematic characters before decoding
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
    // Replace newline and carriage return characters with a space
    return input.replaceAll(RegExp(r'[\r\n]', unicode: true), ' ');
  }
}
