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

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully')),
          );
        }
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return OtpVerification(
                email: email,
                title: 'newUser',
              );
            },
          ));
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('errors')) {
          if (context.mounted) {
            String errorMessage = responseBody['errors'].isNotEmpty ? responseBody['errors'].first['msg'] : 'An error occurred';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An unexpected error occurred: ${response.body}')),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: ${response.body}')),
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

  //Login Api hit
  Future<void> loginApis({
    required String email,
    required String password,
  }) async {
    // Check if the user is blocked or has remaining attempts
    if (await _checkLoginAttempts(context)) {
      return; // Exit if the user is blocked or exceeded attempts
    }

    final url = Uri.parse("$baseUrl/$signInEndP");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "password": password,
      "fcmToken": await notificationServices.getDeviceToken(),
    });

    try {
      Response response = await post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Reset failed attempts on successful login
        await _resetLoginAttempts();

        if (context.mounted) {
          MySharedPreferences.setString(authTokenKey, responseBody['token']);
          MySharedPreferences.setString(userIdKey, responseBody["user"]['_id']);
          MySharedPreferences.setString(userNameKey, responseBody["user"]['fullname']);
          MySharedPreferences.setString(subscriptionKey, responseBody["user"]['subscription']["expiryDate"] ?? "");
          MySharedPreferences.setBool(isLoggedInKey, true);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
        }

        if (context.mounted) {
          Get.offAll(const CustomBottomNavigationBar());
        }
      } else {
        await _incrementLoginAttempts();
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

  //OtpVerify Api
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
      // Change to the success status code
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

  //OtpVerify Api
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully')),
        );
      }
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      MySharedPreferences.setString(authTokenKey, responseBody['token']);
      if (title == "newUser") {
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ));
        }
      } else {
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const CreateNewPassword();
            },
          ));
        }
      }
    } else if (response.statusCode == 400) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid or expired OTP')),
        );
      }
    }
  }

  //Reset Your Password Api
  Future<void> resetPassword({required String newPassword, required String confirmPassword, required String token}) async {
    final url = Uri.parse("$baseUrl/$resetPasswordEp");
    final headers = {"Content-Type": "application/json", "Authorization": "Bearer $token"};
    final body = jsonEncode({
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully')),
        );
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody["message"])),
        );
      }
    }
  }

  // Function to check login attempts and block the user if necessary
  Future<bool> _checkLoginAttempts(BuildContext context) async {
    // Get the current number of failed attempts (default to 0 if not found)
    int failedAttempts = MySharedPreferences.getInt('failedAttempts') ?? 0;

    // If failed attempts are 5 or more, block the user
    if (failedAttempts >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have been blocked due to multiple failed login attempts.')),
      );
      return true; // User is blocked
    }
    // Warn the user on the 3rd attempt (2 attempts left)
    else if (failedAttempts == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have 2 attempts left before you are blocked.')),
      );
    }
    // Warn the user on the 4th attempt (1 attempt left)
    else if (failedAttempts == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have 1 attempt left before you are blocked.')),
      );
    }

    // Allow the user to continue login process
    return false;
  }


  // Function to increment login attempts
  Future<void> _incrementLoginAttempts() async {
    int failedAttempts = MySharedPreferences.getInt('failedAttempts') ?? 0;
    failedAttempts++;
    await MySharedPreferences.setInt('failedAttempts', failedAttempts);
  }

  // Function to reset login attempts on successful login
  Future<void> _resetLoginAttempts() async {
    await MySharedPreferences.setInt('failedAttempts', 0);
  }
}
