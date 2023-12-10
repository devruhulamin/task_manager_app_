import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_status_count_model.dart';
import 'package:task_manager_app/utilities/urls.dart';

class TaskStatusController extends GetxController {
  List<TaskStatusCountModel> _taksStatus = [];
  bool _loading = false;

  List<TaskStatusCountModel> get taskStatus => _taksStatus;
  bool get isLoading => _loading;
  Future<bool> getTaskStatus() async {
    try {
      _loading = true;
      update();
      final response = await NetworkCaller().getRequest(url: getTaskStatusUrl);
      final List<TaskStatusCountModel> taskStatus = [];
      if (response.isSuccess) {
        final data = response.jsonResponse;
        // print('data from here');
        for (final taskCount in data['data']) {
          final parseData = TaskStatusCountModel.fromJson(taskCount);
          taskStatus.add(parseData);
        }
        _taksStatus = taskStatus;
        _loading = false;
        update();
        return true;
      }
      _loading = false;
      update();
      return false;
    } catch (e) {
      _loading = false;
      update();
    }
    return false;
  }
}
