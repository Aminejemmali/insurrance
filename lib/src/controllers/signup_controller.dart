import 'package:flutter/material.dart';

class SignUpController with ChangeNotifier {
  String? emailValidator;
  String? passwordValidator;

  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController birthDate =
      TextEditingController();
  TextEditingController address =
      TextEditingController();
  TextEditingController codePostal =
      TextEditingController();

    TextEditingController phoneNumber =
      TextEditingController();
  void signup() {
    
  }
    void update() {
    super.notifyListeners();
  }
}
