import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/user_mode.dart';
import 'package:task_manager_app/utilities/urls.dart';

class LoginController extends GetxController {
  bool _loginProgress = false;
  String? _failedMessage;
  bool get loginProgress => _loginProgress;
  String? get loginFaildMessage => _failedMessage;
  Future<bool> login(String email, String password) async {
    final networkCaller = NetworkCaller();
    final authController = Get.put(AuthController());
    try {
      _loginProgress = true;
      update();
      final response = await networkCaller.postRequest(url: loginUrl, data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        final token = response.jsonResponse['token'];
        final userData = UserModel.fromJson(response.jsonResponse['data']);
        authController.saveUserAuthData(token, userData);
        _loginProgress = false;
        update();
        return true;
      } else {
        _failedMessage = response.errorMessage;
        _loginProgress = false;
        update();
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
