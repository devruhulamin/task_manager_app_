import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';
import 'package:task_manager_app/utilities/fetch_task.dart';
import 'package:task_manager_app/utilities/urls.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileBar(),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder(
          future: fetchTaskItem(getProgressTaskUrl),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          type: TaskType.progress,
                          task: data[index],
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        )
      ],
    );
  }
}
