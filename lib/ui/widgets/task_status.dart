import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/task_status_controller.dart';
import 'package:task_manager_app/ui/widgets/status_card.dart';

class TaskStatusSection extends StatefulWidget {
  const TaskStatusSection({super.key});

  @override
  State<TaskStatusSection> createState() => _TaskStatusSectionState();
}

class _TaskStatusSectionState extends State<TaskStatusSection> {
  @override
  void initState() {
    Get.put(TaskStatusController()).getTaskStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskStatusController>(builder: (controller) {
      return Visibility(
        visible: controller.isLoading == false,
        replacement: const LinearProgressIndicator(),
        child: SizedBox(
          height: 80,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = controller.taskStatus;
                return StatusCard(
                    count: "${data[index].sum}",
                    labelText: '${data[index].sId}');
              },
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: controller.taskStatus.length),
        ),
      );
    });
  }
}
