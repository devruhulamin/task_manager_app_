import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/controller/register_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
          ))),
      home: const SplashScreen(),
      initialBinding: GetxInitialBinding(),
    );
  }
}

class GetxInitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegisterController());
  }
}
