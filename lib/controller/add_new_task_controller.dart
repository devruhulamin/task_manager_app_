import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/utilities/urls.dart';

class AddNewTaskController extends GetxController {
  String _message = '';
  bool _isloading = false;
  bool get loading => _isloading;
  String get message => _message;
  Future<bool> addNewTask(String title, String desc) async {
    final data = {
      "title": title,
      "description": desc,
      "status": "new",
    };
    try {
      _isloading = true;
      update();
      final response =
          await NetworkCaller().postRequest(url: createTaskUrl, data: data);
      if (response.isSuccess) {
        _message = 'Task Added Successfully';
        _isloading = false;
        update();
        return true;
      } else {
        _message = 'Could not added Task! Try Again';
        _isloading = false;
        update();
        return false;
      }
    } catch (e) {
      _message = 'Could not added Task! Try Again';
      _isloading = false;
      update();
      return false;
    }
  }
}
