import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/cancel_taks_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final controller = Get.put(CancellTaskController());

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
      GetBuilder<CancellTaskController>(
        builder: (controller) {
          final data = controller.cancellTaskList;
          return Visibility(
            visible: controller.isLoading == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Expanded(
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
