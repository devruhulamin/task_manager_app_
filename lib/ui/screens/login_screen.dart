import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultBackGround(
          child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 200, left: 50, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Started With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Email: ',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Password: ',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
