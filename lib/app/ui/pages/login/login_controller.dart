import 'package:flutter/material.dart';
import 'package:google_maps_test/app/helpers/valid_name_and_pass.dart';
import 'package:google_maps_test/app/helpers/validators.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;
  
  ValidationItem? usernameTextV = ValidationItem(null, null);
  ValidationItem? passwordTextV = ValidationItem(null, null);

  LoginController({required String usename, required String password});

  ValidationItem get username => usernameTextV!;
  ValidationItem get password => passwordTextV!;

  bool get validate{
    if (passwordTextV!.value != null && usernameTextV!.value != null &&
        passwordTextV!.value!.isNotEmpty && usernameTextV!.value!.isNotEmpty){
      return true;
    } else {
      return false;
    }
  }

  String? usernameCahnged(String text){
    if (text.isEmpty) {
      usernameTextV = ValidationItem(null, 'This field is required');
    }
    else if (text.length < 6) {
      usernameTextV = ValidationItem(null, 'Data length less than the minimum required');
    }
    else if (text.length > 20){
      usernameTextV = ValidationItem(null, 'Data length less than the maximum required');
    }
    else if (!text.isValidUsername) {
      usernameTextV = ValidationItem(null, 'Invalid Data');
    }
    else {
      usernameTextV = ValidationItem(text, null);
    }
  }

  String? passwordChanged(String text) {
    if (text.isEmpty) {
      passwordTextV = ValidationItem(null, 'This flied is required');
    } else if (text.length < 6) {
      passwordTextV = ValidationItem(null, 'Data length less than the minimum required');
    } else if (text.length > 12) {
      passwordTextV = ValidationItem(null, 'Data length less than the maximum required');
    } else if (!text.isValidPassword) {
      passwordTextV = ValidationItem(null, 'Invalid Data');
    } else {
      passwordTextV = ValidationItem(text, null);
    }
  }

  void passwordVisibleToggle() {
    if (passwordVisible == true) {
      iconPassword = Icons.visibility_rounded;
    } else {
      iconPassword = Icons.visibility_off_rounded;
    }
    passwordVisible = !passwordVisible;
  }
}