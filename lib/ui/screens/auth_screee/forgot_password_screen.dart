import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/screens/auth_screee/pin_verification_scree.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';
import 'package:task_manager_app/utilities/urls.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formglobalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: DefaultBackGround(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 200, left: 50, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formglobalKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Email Address",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "A 6 digit verification pin will send to your email address.",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null) {
                                return 'Invalid Email Value';
                              }
                              if (value.trim().isEmpty) {
                                return 'please insert an email';
                              }
                              if (!value.isValidEmail()) {
                                return 'Email is not Valid ';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              hintText: 'Email: ',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                formglobalKey.currentState?.validate();
                                final response = await NetworkCaller()
                                    .getRequest(
                                        url: recoveryVerifiyEmail(
                                            emailController.text));

                                if (response.isSuccess) {
                                  if (mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PinVerificationScreen(
                                            email: emailController.text,
                                          ),
                                        ));
                                  }
                                }
                              },
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                                          builder: (context) =>
                                              const LoginScreen(),
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
                        ]),
                  ),
                )),
          ),
        ));
  }
}
