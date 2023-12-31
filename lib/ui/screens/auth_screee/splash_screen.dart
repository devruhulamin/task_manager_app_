import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/screens/home_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultBackGround(
          child: Center(
        child: SvgPicture.asset(
          'assets/svg/logo.svg',
          width: 100,
        ),
      )),
    );
  }
}

void goToHome(BuildContext context) async {
  final isAuthenticated = await Get.put(AuthController()).checkAuthState();
  Future.delayed(
    const Duration(seconds: 3),
    () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isAuthenticated ? const HomeScreen() : const LoginScreen(),
          ));
    },
  );
}
