import 'package:flutter/material.dart';
import 'package:google_maps_test/app/helpers/valid_name_and_pass.dart';
import 'package:google_maps_test/app/helpers/validators.dart';

class SignInController with ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;
  
  ValidationItem? emailTextV = ValidationItem(null, null);
  ValidationItem? usernameTextV = ValidationItem(null, null);
  ValidationItem? passwordTextV = ValidationItem(null, null);

  ValidationItem get email => emailTextV!;
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

  String? emailChanged(String text){
    if (text.isEmpty) {
      emailTextV = ValidationItem(null, 'This field is required');
    }
    else if (text.length >= 20){
      emailTextV = ValidationItem(null, 'Data length less than the maximum required');
    }
    else if (!text.isValidUsername) {
      emailTextV = ValidationItem(null, 'Invalid Data');
    }
    else {
      emailTextV = ValidationItem(text, null);
    }

    notifyListeners();
  }

  String? usernameChanged(String text){
    if (text.isEmpty) {
      usernameTextV = ValidationItem(null, 'This field is required');
    }
    else if (text.length < 6) {
      usernameTextV = ValidationItem(null, 'Data length less than the minimum required');
    }
    else if (text.length >= 20){
      usernameTextV = ValidationItem(null, 'Data length less than the maximum required');
    }
    else if (!text.isValidUsername) {
      usernameTextV = ValidationItem(null, 'Invalid Data');
    }
    else {
      usernameTextV = ValidationItem(text, null);
    }

    notifyListeners();
  }

  String? passwordChanged(String text) {
    if (text.isEmpty) {
      passwordTextV = ValidationItem(null, 'This field is required');
    } else if (text.length < 6) {
      passwordTextV = ValidationItem(null, 'Data length less than the minimum required');
    } else if (text.length >= 12) {
      passwordTextV = ValidationItem(null, 'Data length less than the maximum required');
    } else if (!text.isValidPassword) {
      passwordTextV = ValidationItem(null, 'Invalid Data');
    } else {
      passwordTextV = ValidationItem(text, null);
    }

    notifyListeners();
  }

  void passwordVisibleToggle() {
    if (passwordVisible == true) {
      iconPassword = Icons.visibility_rounded;
    } else {
      iconPassword = Icons.visibility_off_rounded;
    }
    passwordVisible = !passwordVisible;
    
    notifyListeners();
  }
}