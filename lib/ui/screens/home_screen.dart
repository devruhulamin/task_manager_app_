import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _seletedNavIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home Screen",
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
    );
  }
}
