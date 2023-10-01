import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/Constants/api.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../../UI/custom_widgets/custom_snackbars.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    ProgressDialog dialog = ProgressDialog(
      context,
      title: const Text('Loading'),
      message: const Text('Please wait'),
    );

    try {
      dialog.show();

      var url = Uri.http(apiUrl, '/api/auth/signup');

      await http.post(url, body: {
        'email': email,
        'password': password,
        'name': name,
      });

      CustomSnackBar.showSuccess('SignUp Successfully');
      dialog.dismiss();
      //Get.offAll(() => const TasksScreen());
    } catch (e) {
      CustomSnackBar.showError('SignUp Failed!');
      dialog.dismiss();
      if (kDebugMode) {
        print('Error signing up: $e');
      }
      rethrow;
    }
  }

  Future<void> storeUserData(
      {required String userId,
      required String name,
      required String email}) async {
    /*   try {
      await _firestore.collection('users').doc(userId).set({
        'email': email,
        'uid': userId,
        'name': name,
      });
    } catch (e) {
      CustomSnackBar.showError('Error storing user data: $e');

      rethrow;
    } */
  }
}
