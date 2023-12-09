import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/task_controller.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class NewTaskSection extends StatefulWidget {
  const NewTaskSection({
    super.key,
  });

  @override
  State<NewTaskSection> createState() => _NewTaskSectionState();
}

class _NewTaskSectionState extends State<NewTaskSection> {
  final controller = Get.put(NewTaskController());

  @override
  void initState() {
    controller.fetchTaskItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewTaskController>(
      builder: (controller) {
        final data = controller.newTaskList;
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
                    type: TaskType.newitem,
                    task: data[index],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
