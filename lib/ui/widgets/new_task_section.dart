import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTaskItem(getNewTastUrl),
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
  }
}
