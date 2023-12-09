import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/register_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/login_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    phoneTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultBackGround(
          child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 50, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Join With Us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailTextController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "Please Enter a Value";
                      }
                      if (!value.isValidEmail()) {
                        return 'Please Enter a Valid Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Email: ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: firstNameTextController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "Please Enter a Value";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'First Name: ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lastNameTextController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "Please Enter a Value";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Last name: ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "Please Enter a Value";
                      }
                      if (!value.validatePhoneNumber()) {
                        return 'Please Enter a Valid Phone Number';
                      }
                      return null;
                    },
                    controller: phoneTextController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Phone: ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter a Value";
                      }
                      if (value.length < 6) {
                        return "password should be 6 chararcter long";
                      }
                      return null;
                    },
                    controller: passwordTextController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Password: ',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<RegisterController>(builder: (registerState) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        visible: registerState.isRegisterInProgress == false,
                        child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState?.validate();
                            final result = await registerState.registerAccount(
                                email: emailTextController.text,
                                firstName: firstNameTextController.text,
                                lastName: lastNameTextController.text,
                                password: passwordTextController.text,
                                mobile: phoneTextController.text);
                            if (result) {
                              Get.offAll(const LoginScreen());
                            } else {
                              Get.snackbar('Opps Error Occur',
                                  '${registerState.getErrorMessage}');
                            }
                          },
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(children: [
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already Have An Account?",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAll(const LoginScreen());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
