import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/api.dart';
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
        CustomSnackBar.showSuccess('Login successfully');
        //Get.offAll(() => const TasksScreen());
      } else {
        CustomSnackBar.showError('Credentials failed!');
      }

      dialog.dismiss();
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
      /*   await _auth.sendPasswordResetEmail(email: email); */
      CustomSnackBar.showSuccess('Password reset email sent');
      dialog.dismiss();
    } catch (e) {
      CustomSnackBar.showError('Error sending password reset email: $e');
      dialog.dismiss();
      rethrow;
    }
  }
}
