import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key, this.isClickAble = true});
  final bool isClickAble;

  @override
  Widget build(BuildContext context) {
    final userData = Get.put(AuthController()).userAuthData;
    String? profilePhoto;
    if (userData != null) {
      final base64Image =
          userData.photo?.replaceAll('data:image/png;base64,', '');

      profilePhoto = base64Image;
    }
    return GetBuilder<AuthController>(builder: (controller) {
      return Container(
        decoration: const BoxDecoration(color: Colors.green),
        child: ListTile(
          onTap: () {
            if (isClickAble) {
              Get.to(const UpdateProfileScreen());
            }
          },
          tileColor: Colors.green,
          leading: CircleAvatar(
            child: profilePhoto == null
                ? const Icon(Icons.person)
                : Image.memory(
                    base64Decode(profilePhoto),
                    fit: BoxFit.cover,
                  ),
          ),
          title: Text(
            "${controller.userAuthData?.firstName} ${controller.userAuthData?.lastName}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "${controller.userAuthData?.email}",
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              controller.clearAuthCache();
              Get.offAll(const LoginScreen());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
