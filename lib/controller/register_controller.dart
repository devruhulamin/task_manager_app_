import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/utilities/urls.dart';

class RegisterController extends GetxController {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isRegisterInProgress => _isLoading;
  String? get getErrorMessage => _errorMessage;
  Future<bool> registerAccount(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String mobile}) async {
    final regData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    try {
      _isLoading = true;
      update();
      final response =
          await NetworkCaller().postRequest(url: registerUrl, data: regData);
      if (response.statusCode == 200) {
        _isLoading = false;
        update();
        return true;
      } else {
        _isLoading = false;
        update();
        _errorMessage = response.errorMessage;
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
