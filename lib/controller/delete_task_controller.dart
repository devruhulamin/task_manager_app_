import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/utilities/urls.dart';

class TaskDeleteController extends GetxController {
  String? _errorMessage = '';
  String? get getErrorMessage => _errorMessage;
  Future<bool> deleteTask(String id) async {
    try {
      final response = await NetworkCaller().getRequest(url: deleteTaskUrl(id));
      if (response.isSuccess) {
        return true;
      } else {
        _errorMessage = response.errorMessage;

        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
