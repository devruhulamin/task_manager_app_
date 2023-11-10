import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileBar(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              TaskItem(
                type: TaskType.cancelled,
              ),
              TaskItem(
                type: TaskType.cancelled,
              ),
              TaskItem(
                type: TaskType.cancelled,
              ),
              TaskItem(
                type: TaskType.cancelled,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
