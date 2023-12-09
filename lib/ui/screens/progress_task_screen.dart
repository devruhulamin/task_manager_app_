import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/progress_taks_controller.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final controller = Get.put(ProgressTaskController());

  @override
  void initState() {
    controller.fetchTaskItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileBar(),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<ProgressTaskController>(
          builder: (controller) {
            final data = controller.progressTaskList;
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
                        type: TaskType.progress,
                        task: data[index],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
