import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

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
                type: TaskType.completed,
              ),
              TaskItem(
                type: TaskType.completed,
              ),
              TaskItem(
                type: TaskType.completed,
              ),
              TaskItem(
                type: TaskType.completed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
