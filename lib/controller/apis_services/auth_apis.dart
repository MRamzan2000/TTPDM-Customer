import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/view/screens/auth_section/create_new_password.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';
import 'package:ttpdm/view/screens/auth_section/otp_verification.dart';

import '../../view/screens/bottom_navigationbar.dart';

class AuthApis {
  final BuildContext context;
  AuthApis({required this.context});
  final PreferencesService preferencesService = PreferencesService();
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
                title: 'signUp',
              );
            },
          ));
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('errors')) {
          if (context.mounted) {
            String errorMessage = responseBody['errors'].isNotEmpty
                ? responseBody['errors'].first['msg']
                : 'An error occurred';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('An unexpected error occurred: ${response.body}')),
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
  Future<void> loginApis({required email, required password}) async {
    final url = Uri.parse("$baseUrl/$signInEndP");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "password": password,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final  Map<String, dynamic> responseBody = jsonDecode(response.body);
      log('token is that ${responseBody['token']}');
      if (context.mounted) {
        preferencesService.setLoginStatus(true,responseBody['token']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return  const CustomBottomNavigationBar();
          },
        ));
      }
    } else if (response.statusCode == 404) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        String errorMessage = responseBody['message'].isNotEmpty
            ? responseBody['message']
            : 'An error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected status code: ${response.body}')),
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
      Map<String,dynamic>responseBody=jsonDecode(response.body);
      preferencesService.setAuthToken(responseBody['token']);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return  CreateNewPassword(

            );
          },
        ));
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
  Future<void> resetPassword(
      {required String newPassword,
        required String confirmPassword,
        required String token}) async {
    final url = Uri.parse("$baseUrl/$resetPasswordEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer $token"
    };
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
            return  LoginScreen();
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
}
