import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

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
                const Chip(
                    label: Text(
                      'New',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue),
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
