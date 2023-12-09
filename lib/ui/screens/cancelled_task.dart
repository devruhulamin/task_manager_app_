import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/task_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';
import 'package:task_manager_app/utilities/fetch_task.dart';
import 'package:task_manager_app/utilities/urls.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
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
            future: controller.fetchTaskItem(getCancelledTaskUrl),
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
                              type: TaskType.cancelled,
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
