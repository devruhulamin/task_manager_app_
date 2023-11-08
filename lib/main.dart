import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
