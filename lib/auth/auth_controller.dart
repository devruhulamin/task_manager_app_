import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/model/user_mode.dart';

class AuthController extends GetxController {
  String? userAuthToken;
  UserModel? userAuthData;

  Future<void> saveUserAuthData(String authToken, UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authToken);
    prefs.setString('userData', jsonEncode(user.toJson()));
    userAuthToken = authToken;
    userAuthData = user;
  }

  Future<void> updateAuthData(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(user.toJson()));
    userAuthData = user;
    update();
  }

  Future<void> initilizeAuthCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userAuthToken = prefs.getString('token');
    final data = prefs.getString('userData');
    if (data != null) {
      userAuthData = UserModel.fromJson(jsonDecode(data));
    }
  }

  Future<bool> checkAuthState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      await initilizeAuthCache();
      return true;
    }
    return false;
  }

  Future<void> clearAuthCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
