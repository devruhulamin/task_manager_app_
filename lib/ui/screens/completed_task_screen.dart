import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/complete_task_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final controller = Get.put(CompleteTaskController());

  @override
  void initState() {
    controller.fetchTaskItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const ProfileBar(),
      const SizedBox(
        height: 10,
      ),
      GetBuilder<CompleteTaskController>(
        builder: (controller) {
          final data = controller.completeTaskList;
          return Visibility(
            visible: controller.isLoading == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future(() {
                    controller.fetchTaskItem();
                  });
                },
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      type: TaskType.completed,
                      task: data[index],
                    );
                  },
                ),
              ),
            ),
          );
        },
      )
    ]);
  }
}
