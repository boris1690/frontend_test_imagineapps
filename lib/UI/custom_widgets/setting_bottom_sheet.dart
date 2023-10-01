import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/providers/task_provider.dart';
import 'package:provider/provider.dart';
import '../../../UI/custom_widgets/custom_buttons.dart';
import '../../../UI/custom_widgets/custom_textfield.dart';

class SettingsBottomSheet extends StatelessWidget {
  final String username;
  final Function(String) onUsernameChanged;
  final Function() onUpdatePressed;
  final Function() onLogoutPressed;

  const SettingsBottomSheet({
    super.key,
    required this.username,
    required this.onUsernameChanged,
    required this.onUpdatePressed,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'User Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: TextEditingController(text: username),
              hintText: username,
              prefixIcon: const Icon(Icons.person),
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: TextEditingController(
                  text: "Total task: ${taskService.taskStream.length}"),
              hintText: username,
              prefixIcon: const Icon(Icons.format_list_bulleted),
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            MyButtonLong(
              name: 'Logout',
              onTap: onLogoutPressed,
              color: Colors.red,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
