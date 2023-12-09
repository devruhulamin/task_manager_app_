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
  Widget build(BuildContext context) {
    return GetBuilder<TaskStatusController>(builder: (controller) {
      return FutureBuilder(
        future: controller.getTaskStatus(),
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
    });
  }
}
