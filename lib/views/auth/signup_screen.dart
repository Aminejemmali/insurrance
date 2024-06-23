import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insurrance/src/api/user/signup.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/controllers/signup_controller.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:insurrance/src/widgets/auth_form_field.dart';
import 'package:insurrance/src/widgets/button_widget.dart';
import 'package:insurrance/util/pickdate.dart';
import 'package:insurrance/views/auth/login_screen.dart';
import 'package:insurrance/views/home/index_home.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  final PageController controller;
  const SignupScreen({super.key, required this.controller});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String errorMessage = "";
    return Consumer<SignUpController>(
      builder: (context, signUpController, child) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
          inAsyncCall: loading,
          child: Scaffold(
            backgroundColor: AppColors.offWhite,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/sk.png",
                        width: 300,
                        height: 200,
                      ),
                      const Text(
                        "Create an Account",
                        style: AppTextStyles.bodyTextStyle8,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Create an account as a Customer",
                        style: AppTextStyles.bodyTextStyle1,
                      ),
                      const SizedBox(height: 28),
                      AuthTextFormFieldWidget(
                        hintText: 'First Name',
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/User.png",
                        controller: signUpController.signUpFirstNameController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormFieldWidget(
                        hintText: 'Last Name',
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/User.png",
                        controller: signUpController.signUpLastNameController,
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormFieldWidget(
                        hintText: 'Email',
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/Message.png",
                        controller: signUpController.signUpEmailController,
                        errorText: signUpController.emailValidator,
                        onChanged: (value) {
                          signUpController.emailValidator = null;
                          signUpController.update();
                        },
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return 'Field Required';
                          } else {
                            if (!(value?.contains('@') ?? false) || !(value?.contains('.') ?? false)) {
                              return 'Please make sure your email address is valid';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthPasswordFormFieldWidget(
                        hintText: 'Password',
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/Unlock.png",
                        errorText: signUpController.passwordValidator,
                        controller: signUpController.signUpPasswordController,
                        onChanged: (value) {
                          signUpController.passwordValidator = null;
                          signUpController.update();
                        },
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return "Field Required";
                          } else if ((value?.length ?? 0) < 8) {
                            return 'Password must contain at least 8 characters';
                          }
                          return null;
                        },
                        suffixIcon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: AppColors.lightGrey,
                        ),
                        suffixIconOnTap: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        obsecureText: obscurePassword,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        style: AppTextStyles.hintTextStyle1,
                        controller: signUpController.birthDate,
                        readOnly: true,
                        onTap: () async {
                          DateTime? dateTime = await selectDate(context);
                          if (dateTime != null) {
                            signUpController.birthDate.text =
                                DateFormat('yyyy-MM-dd').format(dateTime);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Birth date",
                          hintStyle: AppTextStyles.hintTextStyle1,
                          labelStyle: AppTextStyles.hintTextStyle1,
                          errorStyle: AppTextStyles.bodyTextStyle1,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          isDense: true,
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(10),
                            height: 20,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: ImageIcon(
                                AssetImage("assets/icons/User.png"),
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1,
                                color: AppColors.customDialogErrorColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormFieldWidget(
                        controller: signUpController.address,
                        hintText: "Address",
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/User.png",
                        onChanged: (value) {
                          signUpController.update();
                        },
                        validator: (value) {},
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormFieldWidget(
                        controller: signUpController.codePostal,
                        hintText: "Code Postal",
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/User.png",
                        onChanged: (value) {
                          signUpController.update();
                        },
                        validator: (value) {},
                      ),
                      const SizedBox(height: 16),
                      AuthTextFormFieldWidget(
                        controller: signUpController.phoneNumber,
                        hintText: "Phone number",
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/User.png",
                        onChanged: (value) {
                          signUpController.update();
                        },
                        validator: (value) {},
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ButtonWidgetOne(
                        borderRadius: 10,
                        buttonColor: AppColors.primaryColor,
                        buttonText: 'Signup',
                        buttonTextStyle: AppTextStyles.buttonTextStyle1,
                        onTap: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            loading = !loading;
                          });
                          if (_signUpFormKey.currentState!.validate()) {
                            try {
                              FirebaseAuthResult authResult = await UserAuth()
                                  .signUpWithEmailAndPassword(
                                      context,
                                      signUpController
                                          .signUpEmailController.text,
                                      signUpController
                                          .signUpPasswordController.text);
                              if (authResult.user != null) {
                                final Map<String, dynamic> userData = {
                                  "id":
                                      FirebaseAuth.instance.currentUser!.uid,
                                  "nom": signUpController
                                      .signUpFirstNameController.text,
                                  "prenom": signUpController
                                      .signUpLastNameController.text,
                                  "email": FirebaseAuth
                                      .instance.currentUser!.email,
                                  "password": signUpController
                                      .signUpPasswordController.text,
                                  "date_naissance":
                                      signUpController.birthDate.text,
                                  "adresse": signUpController.address.text,
                                  "code_postale":
                                      signUpController.codePostal.text,
                                  "num_tel":
                                      signUpController.phoneNumber.text
                                };
                                String dataAdded =
                                    await signUpUser(userData);
                                setState(() {
                                  errorMessage = dataAdded;
                                });
                                if (dataAdded == "success") {
                                 
                          widget.controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(errorMessage)));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(authResult.errorMessage ??
                                            'An unexpected error occurred.')));
                              }
                            } catch (e) {
                              setState(() {
                                errorMessage = e.toString();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)));
                            } finally {
                              setState(() {
                                loading = !loading;
                              });
                            }
                          } else {
                            setState(() {
                              loading = !loading;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () {
                          widget.controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text(
                            "Have already account please sign in",
                            style: AppTextStyles.underlineTextStyle1),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
