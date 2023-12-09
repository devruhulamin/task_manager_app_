import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/utilities/urls.dart';

class CompleteTaskController extends GetxController {
  List<TaskModel> _taskList = [];
  bool _isLoading = false;

  List<TaskModel> get completeTaskList => _taskList;
  bool get isLoading => _isLoading;
  Future<bool> fetchTaskItem() async {
    try {
      _isLoading = true;
      update();
      final response =
          await NetworkCaller().getRequest(url: getCompleteTaskUrl);
      if (response.isSuccess) {
        final data = response.jsonResponse;
        if (data['data'].length == 0) {
          _isLoading = false;
          update();
          return false;
        }
        final List<TaskModel> tlist = [];
        for (final task in data['data']) {
          final parseTask = TaskModel.fromJson(task as Map<String, dynamic>);
          tlist.add(parseTask);
        }
        _isLoading = false;
        update();
        _taskList = tlist;
        return true;
      }
    } catch (e) {
      _isLoading = false;
      update();
      rethrow;
    }
    return false;
  }
}
