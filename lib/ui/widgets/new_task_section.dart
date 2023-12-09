import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/task_controller.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';
import 'package:task_manager_app/utilities/fetch_task.dart';
import 'package:task_manager_app/utilities/urls.dart';

class NewTaskSection extends StatefulWidget {
  const NewTaskSection({
    super.key,
  });

  @override
  State<NewTaskSection> createState() => _NewTaskSectionState();
}

class _NewTaskSectionState extends State<NewTaskSection> {
  // final controller = Get.put(TaskController());

  // @override
  // void initState() {
  //   super.initState();
  //   controller.fetchTaskItem(getNewTastUrl);
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (taskcontroller) {
      return FutureBuilder(
        future: taskcontroller.fetchTaskItem(getNewTastUrl),
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
                          type: TaskType.newitem,
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
    });
  }
}
