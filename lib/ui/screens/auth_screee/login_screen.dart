import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/login_controller.dart';
import 'package:task_manager_app/ui/screens/auth_screee/forgot_password_screen.dart';
import 'package:task_manager_app/ui/screens/auth_screee/register_screen.dart';
import 'package:task_manager_app/ui/screens/home_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextField = TextEditingController();
  final _passwordTextField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextField.dispose();
    _passwordTextField.dispose();
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
              const EdgeInsets.only(top: 200, left: 50, right: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    controller: _emailTextField,
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
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Email: ',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordTextField,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter a Value";
                      }
                      if (value.length < 6) {
                        return "password should be 6 chararcter long";
                      }
                      return null;
                    },
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
                    child:
                        GetBuilder<LoginController>(builder: (logincontroller) {
                      return Visibility(
                        visible: logincontroller.loginProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState?.validate();

                            final isSuccess = await logincontroller.login(
                                _emailTextField.text.trim(),
                                _passwordTextField.text);
                            if (isSuccess) {
                              Get.offAll(const HomeScreen());
                            } else {
                              Get.snackbar('Opps Error Occur',
                                  '${logincontroller.loginFaildMessage}');
                            }
                          },
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ));
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have Account?",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ));
                            },
                            child: const Text(
                              "Signup",
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
