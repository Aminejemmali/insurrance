import 'package:flutter/material.dart';

class SignUpController with ChangeNotifier {
  String? emailValidator;
  String? passwordValidator;

  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  
  void signup() {
    
  }
    void update() {
    super.notifyListeners();
  }
}
