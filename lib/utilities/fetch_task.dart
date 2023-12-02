import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_model.dart';

Future<List<TaskModel>?> fetchTaskItem(String url) async {
  List<TaskModel> tasklist = [];
  final response = await NetworkCaller().getRequest(url: url);
  try {
    if (response.isSuccess) {
      final data = response.jsonResponse;
      if (data['data'].length == 0) {
        return tasklist;
      }
      for (final task in data['data']) {
        final parseTask = TaskModel.fromJson(task as Map<String, dynamic>);
        tasklist.add(parseTask);
      }
      return tasklist;
    }
  } catch (e) {
    rethrow;
  }

  return null;
}
