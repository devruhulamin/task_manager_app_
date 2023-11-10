import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/cancelled_task.dart';
import 'package:task_manager_app/ui/screens/completed_task_screen.dart';
import 'package:task_manager_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/progress_task_screen.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _seletedNavIdx = 0;
  final _screen = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screen[_seletedNavIdx],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _seletedNavIdx,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            _seletedNavIdx = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.note_add,
              ),
              label: 'New Tasks',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add,
                ),
                label: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add,
                ),
                label: 'Cancelled'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add,
                ),
                label: 'Progress'),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewTaskScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
