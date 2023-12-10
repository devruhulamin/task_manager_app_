import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/main.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest({
    required String url,
    required dynamic data,
    bool isLogin = false,
  }) async {
    try {
      // print("Token is : ${AuthController().userAuthToken}");
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'token': '${Get.put(AuthController()).userAuthToken}',
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        // print(response.body);
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLoginPage();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getRequest({
    required String url,
  }) async {
    try {
      // print("Token is : ${AuthController().userAuthToken}");
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': '${Get.put(AuthController()).userAuthToken}',
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLoginPage();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  void backToLoginPage() {
    AuthController().clearAuthCache();
    Navigator.pushAndRemoveUntil(
        MyApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}
