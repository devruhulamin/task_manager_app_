import 'package:flutter/material.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/ui/screens/home_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';
import 'package:task_manager_app/utilities/urls.dart';

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
  bool _isLoading = false;
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
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      visible: _isLoading == false,
                      child: ElevatedButton(
                        onPressed: () async {
                          formKey.currentState?.validate();
                          _isLoading = true;
                          setState(() {});
                          final regData = {
                            "email": emailTextController.text,
                            "firstName": firstNameTextController.text,
                            "lastName": lastNameTextController.text,
                            "mobile": phoneTextController.text,
                            "password": passwordTextController.text,
                          };
                          final response = await NetworkCaller()
                              .postRequest(url: registerUrl, data: regData);
                          if (response.statusCode == 200) {
                            _isLoading = false;
                            setState(() {});
                            if (mounted) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (route) => false);
                            }
                          }
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Column(children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have Account?",
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
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
