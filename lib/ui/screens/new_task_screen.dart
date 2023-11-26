import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/new_task_section.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/task_status.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProfileBar(),
        SizedBox(
          height: 10,
        ),
        TaskStatusSection(),
        SizedBox(
          height: 15,
        ),
        NewTaskSection(),
      ],
    );
  }
}
