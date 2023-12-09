import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/utilities/urls.dart';

enum TaskType { cancelled, completed, progress, newitem }

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.type,
    required this.task,
  });

  final TaskType type;
  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.task.title}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${widget.task.description}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Date: ${widget.task.createdDate}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Chip(
                    label: Text(
                      getTypeText(widget.type),
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: getTypeColor(widget.type)),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      final isDel = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Deleting Task"),
                            content:
                                const Text("Are you Sure Wanna Delete Task?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Okay!'))
                            ],
                          );
                        },
                      );
                      if (isDel ?? false) {
                        final response = await NetworkCaller()
                            .getRequest(url: deleteTaskUrl(widget.task.sId!));
                        if (response.isSuccess) {}
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                DropdownButton<String>(
                  // value: optionValue,
                  hint: const Text("Change Status"),
                  items: const [
                    DropdownMenuItem(
                      value: 'new',
                      child: Text('New'),
                    ),
                    DropdownMenuItem(
                      value: 'Completed',
                      child: Text('Completed'),
                    ),
                    DropdownMenuItem(
                      value: 'cancelled',
                      child: Text('Cancelled'),
                    ),
                    DropdownMenuItem(
                        value: 'progress', child: Text('Progress')),
                  ],
                  onChanged: (value) async {
                    if (value == null) {
                      return;
                    }

                    final response = await NetworkCaller().getRequest(
                        url: updateTaskUrl(widget.task.sId!, value));
                    if (response.isSuccess) {}
                    setState(() {});
                  },
                ),
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

String getRefreshUrl(TaskType type) {
  switch (type) {
    case TaskType.cancelled:
      return getCancelledTaskUrl;
    case TaskType.completed:
      return getCompleteTaskUrl;
    case TaskType.progress:
      return getProgressTaskUrl;
    case TaskType.newitem:
      return getNewTastUrl;
  }
}
