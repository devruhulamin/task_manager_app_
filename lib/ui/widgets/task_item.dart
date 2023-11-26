import 'package:flutter/material.dart';
import 'package:task_manager_app/model/task_model.dart';

enum TaskType { cancelled, completed, progress, newitem }

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.type,
    required this.task,
  });

  final TaskType type;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${task.description}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Date: ${task.createdDate}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Chip(
                    label: Text(
                      getTypeText(type),
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: getTypeColor(type)),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_task_rounded,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color getTypeColor(TaskType type) {
  if (type == TaskType.cancelled) {
    return Colors.red;
  } else if (type == TaskType.completed) {
    return Colors.green;
  } else if (type == TaskType.newitem) {
    return Colors.blue;
  } else {
    return Colors.purple;
  }
}

String getTypeText(TaskType type) {
  if (type == TaskType.cancelled) {
    return 'cancelled';
  } else if (type == TaskType.completed) {
    return 'completed';
  } else if (type == TaskType.newitem) {
    return 'new';
  } else {
    return 'progress';
  }
}
