import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyToken = 'auth_token';
  static const String deviceToken = 'device_Token';
  String? cachedToken;

  /// Saves the login status and auth token to shared preferences.
  Future<void> setLoginStatus(bool isLoggedIn, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, isLoggedIn);
    await setAuthToken(token);
  }

  /// Retrieves the login status from shared preferences.
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  /// Stores the auth token.
  Future<void> setAuthToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(keyToken, token);
    } catch (e) {
      log('Something went wrong: ${e.toString()}');
    }
  }
  /// Stores the auth token.
  Future<void> setDeviceToken(String deviceToken) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(deviceToken, deviceToken);
      cachedToken = deviceToken; // Cache the token
    } catch (e) {
      log('Something went wrong: ${e.toString()}');
    }
  }
  Future<String?> getAuthToken() async {
    if (cachedToken != null) {
      return cachedToken;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cachedToken = prefs.getString(keyToken);
    log("token is $cachedToken");
    return cachedToken;
  }

  /// Removes the login status from shared preferences.
  Future<void> removeLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyIsLoggedIn);
    // Optionally, clear the cached token when logging out
    cachedToken = null;
  }
}
