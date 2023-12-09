import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_model.dart';

class TaskController extends GetxController {
  Future<List<TaskModel>> fetchTaskItem(String url) async {
    try {
      final response = await NetworkCaller().getRequest(url: url);
      if (response.isSuccess) {
        final data = response.jsonResponse;
        if (data['data'].length == 0) {
          return [];
        }
        final List<TaskModel> tlist = [];
        for (final task in data['data']) {
          final parseTask = TaskModel.fromJson(task as Map<String, dynamic>);
          tlist.add(parseTask);
        }

        return tlist;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
