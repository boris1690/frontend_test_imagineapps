import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/strings.dart';
import 'package:frontend_test_imagineapps/UI/Screens/Task%20screeens/add_task_screen.dart';
import 'package:get/get.dart';
import '../../../Core/Constants/colors.dart';
import '../../../Core/providers/task_provider.dart';
import '../../../UI/custom_widgets/custom_snackbars.dart';
import '../../../UI/custom_widgets/task_block.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/status_dialod.dart';
import '../../custom_widgets/setting_bottom_sheet.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 10),
                  const Text('Hello '),
                  taskProvider.email == null
                      ? const CircularProgressIndicator()
                      : Text(
                          taskProvider.email.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kBlack),
                        ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          SettingsBottomSheet(
                            username: taskProvider.email.toString(),
                            onUsernameChanged: (value) {
                              /* taskProvider.updateUsername(value); */
                            },
                            onUpdatePressed: () {
                              /* taskProvider.updateUserData(); */
                              Get.back();
                            },
                            onLogoutPressed: () {
                              taskProvider.logout();
                              Get.back();
                            },
                          ),
                          backgroundColor: Colors.white,
                        );
                      },
                      icon: const Icon(Icons.settings)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'ToDos',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                itemCount: taskProvider.taskStream.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.taskStream![index];
                  return TaskBlock(
                    title: task.title,
                    description: task.description,
                    status: task.status,
                    onChange: () async {
                      var nextStatus = task.status == taskPending
                          ? taskInProgress
                          : taskCompleted;

                      final confirmed =
                          await CustomDialog.showDeleteConfirmationDialog(
                              context, nextStatus);
                      if (confirmed != null && confirmed) {
                        taskProvider.updateTaskStatus(task.id, nextStatus);

                        CustomSnackBar.showSuccess(
                            'Task Status Changed Successfully');
                      }
                    },
                    done: task.status == taskCompleted ? true : false,
                  );
                },
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => const AddTaskScreen());
            },
            child: const Icon(Icons.add)),
      );
    });
  }
}
