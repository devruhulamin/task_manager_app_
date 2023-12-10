import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/auth/auth_controller.dart';
import 'package:task_manager_app/controller/update_profile_controller.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';
import 'package:task_manager_app/utilities/extension/validator.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final updateForm = GlobalKey<FormState>();
  XFile? profileImage;
  String profileImageName = 'not_selected';
  final updateController = Get.put(UpdateProfileController());
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    emailController.text = authController.userAuthData?.email ?? '';
    firstNameController.text = authController.userAuthData?.firstName ?? '';
    lastNameController.text = authController.userAuthData?.lastName ?? '';
    phoneNumberController.text = authController.userAuthData?.mobile ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultBackGround(
        child: SingleChildScrollView(
          child: Form(
            key: updateForm,
            child: Column(
              children: [
                const ProfileBar(isClickAble: false),
                const SizedBox(height: 50),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final pickedImage = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (pickedImage == null) {
                                  return;
                                }
                                profileImage = pickedImage;
                                profileImageName = pickedImage.name;
                                setState(() {});
                              },
                              child: Container(
                                // width: 50,
                                alignment: Alignment.center,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: const Text(
                                  "Photos",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              // width: 90,
                              alignment: Alignment.centerLeft,
                              height: 35,
                              color: Colors.white,
                              child: Text(profileImageName),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Insert a Value';
                          }
                          if (value.trim().isEmpty) {
                            return 'Enter A valid Value';
                          }
                          if (!value.isValidEmail()) {
                            return 'Email is Invalid!';
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
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Insert a Value';
                          }
                          if (value.trim().isEmpty) {
                            return 'Enter A valid Value';
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
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Insert a Value';
                          }
                          if (value.trim().isEmpty) {
                            return 'Enter A valid Value';
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
                        controller: phoneNumberController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Insert a Value';
                          }
                          if (value.trim().isEmpty) {
                            return 'Enter A valid Value';
                          }
                          if (!value.validatePhoneNumber()) {
                            return 'Email is Invalid!';
                          }
                          return null;
                        },
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
                        controller: passwordController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please Insert a Value';
                          }
                          if (value.trim().isEmpty) {
                            return null;
                          }
                          if (value.trim().length < 6) {
                            return 'password should 6 char long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Password: (optional)',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: GetBuilder<UpdateProfileController>(
                            builder: (controller) {
                          return Visibility(
                            visible: controller.isLoading == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                updateProfile();
                              },
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> updateProfile() async {
    Map<String, dynamic> data = {
      "email": emailController.text,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "mobile": phoneNumberController.text,
    };
    final updatedUser = authController.userAuthData;
    updatedUser?.email = emailController.text;
    updatedUser?.firstName = firstNameController.text;
    updatedUser?.lastName = lastNameController.text;
    if (passwordController.text.isNotEmpty) {
      data['password'] = passwordController.text;
      updatedUser?.password = passwordController.text;
    }
    String imagebase64;
    if (profileImage != null) {
      final baseByte = await profileImage?.readAsBytes();
      if (baseByte != null) {
        imagebase64 = base64Encode(baseByte);
        data['photo'] = imagebase64;
        updatedUser?.photo = imagebase64;
      }
    }
    final res = await updateController.updateProfile(data, updatedUser!);
    if (res) {
      Get.back();
    } else {
      Get.snackbar('Opps Error', 'could not update user');
    }
  }
}
