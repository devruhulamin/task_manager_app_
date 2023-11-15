import 'package:flutter/material.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/model/user_mode.dart';
import 'package:task_manager_app/ui/screens/home_screen.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';
import 'package:task_manager_app/utilities/urls.dart';

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
                    child: ElevatedButton(
                      onPressed: () async {
                        final data = {
                          "email": _emailTextField.text,
                          "password": _passwordTextField.text,
                        };
                        await _signIn(data);
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
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

  Future<void> _signIn(Map<String, String> loginData) async {
    final networkCaller = NetworkCaller();
    final authController = AuthController();
    try {
      final response =
          await networkCaller.postRequest(url: loginUrl, data: loginData);
      if (response.statusCode == 200) {
        final token = response.jsonResponse['token'];
        final userData = UserModel.fromJson(response.jsonResponse['data']);
        authController.saveUserAuthData(token, userData);
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
