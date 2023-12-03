import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/status_snackbar.dart';
import 'package:task_manager_app/utilities/urls.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formStateKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

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
            child: Form(
              key: formStateKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Minimum password lenth should be 8 character long including letter numbers",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null) {
                        return 'Enter a Valid Value';
                      }
                      if (value.length < 6) {
                        return 'password must be 6 char long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Password: ',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null) {
                        return 'Enter a Valid Value';
                      }
                      if (value.length < 6) {
                        return 'password must be 6 char long';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Confirm Password: ',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          statusSnackBar(
                              context, 'password dosent Match', true);
                          return;
                        }
                        final data = {
                          "email": widget.email,
                          "OTP": widget.otp,
                          "password": passwordController.text
                        };
                        final response = await NetworkCaller()
                            .postRequest(url: resetPasswordUrl, data: data);
                        if (response.isSuccess) {
                          if (mounted &&
                              response.jsonResponse['status'] == 'fail') {
                            statusSnackBar(context,
                                '${response.jsonResponse["data"]}', true);
                          } else {
                            if (mounted) {
                              statusSnackBar(
                                  context, 'password Reset Successfull', false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false);
                            }
                          }
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have An Account?",
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text(
                            "Signin",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
