import 'package:flutter/material.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key, this.isClickAble = true});
  final bool isClickAble;

  @override
  Widget build(BuildContext context) {
    final userData = AuthController().userAuthData;
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      child: ListTile(
        onTap: () {
          if (isClickAble) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ));
          }
        },
        tileColor: Colors.green,
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          "${userData?.firstName} ${userData?.lastName}",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "${userData?.email}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () {
            AuthController().clearAuthCache();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
