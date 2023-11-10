import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

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
