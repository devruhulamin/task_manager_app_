import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              ));
        },
        tileColor: Colors.green,
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: const Text(
          "Rabbil Hossen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          "rabbil@gmail.com",
          style: TextStyle(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
