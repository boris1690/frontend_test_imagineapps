import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/strings.dart';

import 'package:get/get.dart';
import '../../Core/Constants/colors.dart';

class TaskBlock extends StatelessWidget {
  final String title;
  final bool done;

  final VoidCallback onChange;
  final String description;
  final String status;

  const TaskBlock({
    super.key,
    required this.title,
    required this.description,
    required this.onChange,
    required this.done,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(15), // Set the border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      status,
                      style: TextStyle(
                        color: status == taskCompleted
                            ? Colors.green
                            : status == taskInProgress
                                ? Colors.yellow[900]
                                : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (status != taskCompleted)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: status == taskPending
                              ? Colors.yellow[900]
                              : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onChange,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(
                              status == taskPending
                                  ? taskInProgress
                                  : taskCompleted,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        )),
                ],
              ),
            ],
          ),
        ));
  }
}
