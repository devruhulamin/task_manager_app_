import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_status_count_model.dart';
import 'package:task_manager_app/utilities/urls.dart';

class TaskStatusController extends GetxController {
  Future<List<TaskStatusCountModel>?> getTaskStatus() async {
    final response = await NetworkCaller().getRequest(url: getTaskStatusUrl);
    final List<TaskStatusCountModel> taskStatus = [];
    if (response.isSuccess) {
      final data = response.jsonResponse;
      // print('data from here');
      for (final taskCount in data['data']) {
        final parseData = TaskStatusCountModel.fromJson(taskCount);
        taskStatus.add(parseData);
      }
      return taskStatus;
    }
    return null;
  }
}
