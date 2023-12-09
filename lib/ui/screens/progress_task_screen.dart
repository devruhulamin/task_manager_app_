import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/task_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';
import 'package:task_manager_app/utilities/urls.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileBar(),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<TaskController>(builder: (controller) {
          return FutureBuilder(
            future: controller.fetchTaskItem(getProgressTaskUrl),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return Future(() {
                            setState(() {});
                          });
                        },
                        child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              type: TaskType.progress,
                              task: data[index],
                              taskCallBack: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
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
          );
        })
      ],
    );
  }
}
