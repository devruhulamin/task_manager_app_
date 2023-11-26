import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_status_count_model.dart';
import 'package:task_manager_app/ui/widgets/status_card.dart';
import 'package:task_manager_app/utilities/urls.dart';

class TaskStatusSection extends StatefulWidget {
  const TaskStatusSection({super.key});

  @override
  State<TaskStatusSection> createState() => _TaskStatusSectionState();
}

class _TaskStatusSectionState extends State<TaskStatusSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTaskStatus(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return SizedBox(
                height: 80,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return StatusCard(
                          count: "${data[index].sum}",
                          labelText: '${data[index].sId}');
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 5),
                    itemCount: data.length),
              );
            } else {
              return const LinearProgressIndicator();
            }

          default:
            return const LinearProgressIndicator();
        }
      },
    );
  }
}

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
