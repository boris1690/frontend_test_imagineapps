import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/api.dart';
import 'package:frontend_test_imagineapps/UI/Screens/Task%20screeens/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../UI/custom_widgets/custom_snackbars.dart';
import 'package:ndialog/ndialog.dart';

class LoginProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context,
        title: const Text('Loading'), message: const Text('Please wait'));
    try {
      dialog.show();

      var url = Uri.http(apiUrl, '/api/auth/signin');

      var response =
          await http.post(url, body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        // Persist data
        final Map<String, dynamic> parsed = jsonDecode(response.body);

        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('token', parsed['accessToken']);
        _prefs.setString('name', parsed['name']);
        _prefs.setString('email', parsed['email']);
        _prefs.setInt('id', parsed['id']);

        CustomSnackBar.showSuccess('Login successfully');
        dialog.dismiss();
        Get.to(() => const TasksScreen());
      } else {
        CustomSnackBar.showError('Credentials failed!');
        dialog.dismiss();
      }
    } catch (e) {
      CustomSnackBar.showError('Error signing in: $e');
      dialog.dismiss();

      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(context,
        title: const Text('Loading'), message: const Text('Please wait'));
    try {
      dialog.show();
      CustomSnackBar.showSuccess('Password reset email sent');
      dialog.dismiss();
    } catch (e) {
      CustomSnackBar.showError('Error sending password reset email: $e');
      dialog.dismiss();
      rethrow;
    }
  }
}
