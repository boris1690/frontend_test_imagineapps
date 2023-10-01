import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/api.dart';
import 'package:frontend_test_imagineapps/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../UI/Screens/Authentication/login_screen.dart';
import '../../../UI/custom_widgets/custom_snackbars.dart';
import 'package:ndialog/ndialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  String? email;
  List<Task> _taskStream = [];
  SharedPreferences? _prefs;

  List<Task> get taskStream => _taskStream;

  TaskProvider() {
    getEmail();
    fetchTasks();
  }

  Future<void> addTask(
      String title, String description, BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context,
        title: const Text('Loading'), message: const Text('Please wait'));

    _prefs = await SharedPreferences.getInstance();
    var token = (prefs?.getString("token"));

    try {
      dialog.show();
      var url = Uri.http(apiUrl, '/api/task/create');
      final body = jsonEncode({'title': title, 'description': description});

      var response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': '$token',
        },
      );

      dialog.dismiss();

      if (response.statusCode == 200) {
        Get.back();
        CustomSnackBar.showSuccess('Task Added Successfully');
        fetchTasks();
      } else {
        CustomSnackBar.showError('Error adding task');
      }
    } catch (e) {
      CustomSnackBar.showError('Error adding task: $e');
      dialog.dismiss();
      rethrow;
    }
  }

  void updateTaskStatus(int taskId, String status) async {
    _prefs = await SharedPreferences.getInstance();
    var token = (prefs?.getString("token"));

    var url = Uri.http(apiUrl, '/api/task/$taskId');
    final body = jsonEncode({'status': status});

    var response = await http.put(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': '$token',
      },
    );

    fetchTasks();
  }

  Future<void> getEmail() async {
    _prefs = await SharedPreferences.getInstance();
    email = (prefs?.getString("email"));

    notifyListeners();
  }

  void logout() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await _prefs?.clear();

      CustomSnackBar.showSuccess('Logout successfully');
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  void fetchTasks() async {
    _prefs = await SharedPreferences.getInstance();
    var token = (prefs?.getString("token"));

    var url = Uri.http(apiUrl, '/api/task');

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': '$token',
    });

    final Map<String, dynamic> body = jsonDecode(response.body);

    _taskStream = ((body['data'] as List<dynamic>)
        .map((e) => Task.fromJson(Map<String, dynamic>.from(e)))
        .toList());

    notifyListeners();
  }
}
