import 'package:get/get.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/user_mode.dart';
import 'package:task_manager_app/utilities/urls.dart';

class UpdateProfileController extends GetxController {
  bool _loading = false;
  bool get isLoading => _loading;

  Future<bool> updateProfile(
      Map<String, dynamic> data, UserModel updateUser) async {
    try {
      _loading = true;
      update();
      final response =
          await NetworkCaller().postRequest(url: profileUpdateUrl, data: data);
      if (response.isSuccess) {
        Get.put(AuthController()).updateAuthData(updateUser);
        _loading = false;
        update();
        return true;
      }
      return false;
    } catch (e) {
      _loading = false;
      update();
      rethrow;
    }
  }
}
