import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/add_new_task_controller.dart';
import 'package:task_manager_app/controller/task_controller.dart';
import 'package:task_manager_app/ui/widgets/default_background.dart';
import 'package:task_manager_app/ui/widgets/profile_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final subjectTextController = TextEditingController();
  final describtionTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    subjectTextController.dispose();
    describtionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultBackGround(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileBar(),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add New Task",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: subjectTextController,
                          validator: (value) {
                            if (value == null) {
                              return "Enter a Valid Text";
                            }
                            if (value.trim().isEmpty) {
                              return 'Enter A Title of Task Subject';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Subject: ',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: describtionTextController,
                          validator: (value) {
                            if (value == null) {
                              return "Enter a Valid Text";
                            }
                            if (value.trim().isEmpty) {
                              return 'Enter A Task Describtion';
                            }
                            return null;
                          },
                          maxLines: 7,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Describtion: ',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: GetBuilder<AddNewTaskController>(
                              builder: (controller) {
                            return Visibility(
                              visible: controller.loading == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  _formKey.currentState?.validate();

                                  final response = await controller.addNewTask(
                                      subjectTextController.text,
                                      describtionTextController.text);
                                  if (response) {
                                    Get.snackbar(
                                        'Succussefull', 'New Task Added Done');
                                    await Get.put(NewTaskController())
                                        .fetchTaskItem();
                                    subjectTextController.clear();
                                    describtionTextController.clear();
                                  } else {
                                    Get.snackbar('Opps Something Went Wrong!',
                                        'Could not Create New Task');
                                  }
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
