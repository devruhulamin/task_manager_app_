import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileBar(),
          ],
        ),
      ),
    );
  }
}
