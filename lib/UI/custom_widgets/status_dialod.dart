import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future<bool?> showDeleteConfirmationDialog(
      BuildContext context, String status) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Status Task'),
        content: Text(
            'Are you sure you want to change status to "$status" this task?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          TextButton(
            child: const Text('Accept'),
            onPressed: () {
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }
}
