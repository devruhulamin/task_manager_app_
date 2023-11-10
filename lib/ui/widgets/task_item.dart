import 'package:flutter/material.dart';

enum TaskType { cancelled, completed, progress, newitem }

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.type,
  });

  final TaskType type;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Learning Korean EveryDay atleast 1 hour',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'learning korean everday makes you korean language flutent in 6 month',
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Date: 10/11/2023",
              style: TextStyle(fontWeight: FontWeight.bold),
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
