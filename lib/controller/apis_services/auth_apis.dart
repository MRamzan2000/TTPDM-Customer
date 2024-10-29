import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/auth_section/create_new_password.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';
import 'package:ttpdm/view/screens/auth_section/otp_verification.dart';
import '../../main.dart';
import '../../view/screens/bottom_navigationbar.dart';

class AuthApis {
  final BuildContext context;

  AuthApis({required this.context});

  Future<void> signUPApis({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    final url = Uri.parse("$baseUrl/$signUpEndP");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "fullname": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": role,
    });
    try {
      Response response = await post(url, body: body, headers: headers);
      if (response.statusCode == 201) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        MySharedPreferences.setString(userIdKey, responseBody["user"]['_id']);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully')),
          );
        }
        Get.offAll(() => OtpVerification(
          email: email,
          title: 'newUser',
        ));
      } else {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody["message"])),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // Login API
  Future<void> loginApis({
    required String email,
    required String password,
  }) async {
    if (await _checkLoginAttempts(context, email)) return; // User is blocked

    try {
      final response = await post(
        Uri.parse("$baseUrl/$signInEndP"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "fcmToken": await notificationServices.getDeviceToken(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if ((data['user']['role'] ?? "").toLowerCase() != "customer") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email is not Customer Type')),
          );
          return;
        }

        await _resetLoginAttempts(email: email);
        MySharedPreferences.setString(authTokenKey, data['token']);
        MySharedPreferences.setString(userIdKey, data["user"]['_id']);
        MySharedPreferences.setString(userNameKey, data["user"]['fullname']);
        MySharedPreferences.setString(subscriptionKey, data["user"]['subscription']["expiryDate"] ?? "");
        MySharedPreferences.setBool(isLoggedInKey, true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Get.offAll(const CustomBottomNavigationBar());
      } else {
        await _incrementLoginAttempts(email);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email or password')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // OtpVerify API
  Future<void> forgetPassword({
    required String email,
  }) async {
    final url = Uri.parse("$baseUrl/$forgetPasswordEp");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
    });

    Response response = await post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP sent to email')),
        );
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return OtpVerification(
              title: 'resetpassword',
              email: email,
            );
          },
        ));
      }
    } else if (response.statusCode == 404) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
    }
  }

  // OtpVerify API
  Future<void> verifyOtp({
    required email,
    required otp,
    required title,
  }) async {
    final url = Uri.parse("$baseUrl/$verifyOtpEp");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "otp": otp,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      MySharedPreferences.setString(authTokenKey, responseBody['token']);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody["message"])),
        );
      }
      if (title == "newUser") {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => CreateNewPassword(email: email.toString()));
      }
    } else {
      log(response.body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody["message"])),
        );
      }
    }
  }

  // Reset Your Password API
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String userEmail,
    required String userId,
  }) async {
    final url = Uri.parse("$baseUrl/$resetPasswordEp$userId");
    final headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      await _resetLoginAttempts(email: userEmail);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully')),
        );
      }
      Get.offAll(() => const LoginScreen());
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body)),
        );
      }
    }
  }

  Future<bool> _checkLoginAttempts(BuildContext context, String userEmail) async {
    int failedAttempts = MySharedPreferences.getInt('failedAttempts_$userEmail');
    List<String> blockedUsers = MySharedPreferences.getStringList('blockedUsers');

    // Check if the user is blocked
    if (blockedUsers.contains(userEmail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Your account has been blocked due to multiple failed login attempts.')),
      );
      return true;
    }

    // Increment attempts and check the limit
    if (failedAttempts >= 5) {
      // Block the user
      blockedUsers.add(userEmail);

      await MySharedPreferences.setStringList('blockedUsers', blockedUsers);

     if(context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
             content: Text(
                 'You have been blocked due to multiple failed login attempts.')),
       );
     }
      return true;
    } else if (failedAttempts == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You have 2 attempts left before you are blocked.')),
      );
    } else if (failedAttempts == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You have 1 attempt left before you are blocked.')),
      );
    }

    // If login fails, increment failed attempts for the specific user
    failedAttempts++;
    await MySharedPreferences.setInt('failedAttempts_$userEmail', failedAttempts); // Save updated count

    return false; // User is not blocked
  }

  // Function to increment login attempts
  Future<void> _incrementLoginAttempts(String userEmail) async {
    int failedAttempts = MySharedPreferences.getInt('failedAttempts_$userEmail');
    failedAttempts++;
    await MySharedPreferences.setInt('failedAttempts_$userEmail', failedAttempts);
  }

  // Function to reset login attempts on successful login
  Future<void> _resetLoginAttempts({required String email}) async {
    List<String> blockedUsers = MySharedPreferences.getStringList('blockedUsers');
    blockedUsers.remove(email);
    await MySharedPreferences.setStringList('blockedUsers', blockedUsers);
    await MySharedPreferences.setInt('failedAttempts_$email', 0);
  }
}
