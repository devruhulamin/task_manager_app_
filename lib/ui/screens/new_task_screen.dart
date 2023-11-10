import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/ui/widgets/status_card.dart';
import 'package:task_manager_app/ui/widgets/task_item.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileBar(),
        const SizedBox(
          height: 10,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StatusCard(count: '08', labelText: 'Cancelled'),
              StatusCard(count: '09', labelText: 'Completed'),
              StatusCard(count: '11', labelText: 'Progress'),
              StatusCard(count: '13', labelText: 'New Task'),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: const [
              TaskItem(
                type: TaskType.newitem,
              ),
              TaskItem(
                type: TaskType.newitem,
              ),
              TaskItem(
                type: TaskType.newitem,
              ),
              TaskItem(
                type: TaskType.newitem,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
