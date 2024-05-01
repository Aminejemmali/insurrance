import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/controllers/signup_controller.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:insurrance/src/widgets/auth_form_field.dart';
import 'package:insurrance/src/widgets/button_widget.dart';
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

  final GlobalKey<FormState> _signUpFromKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                  key: _signUpFromKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/law-hammer.png"),
                      const SizedBox(height: 28),
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
                            if (!value!.contains('@') && !value.contains('.')) {
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
                          if (value!.isEmpty) {
                            return "Field Required";
                          } else if (value.length < 8) {
                            return 'Password must contains 8 digit';
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
                      AuthPasswordFormFieldWidget(
                        hintText: 'Confirm Password',
                        prefixIconColor: AppColors.primaryColor,
                        prefixIcon: "assets/icons/Unlock.png",
                        errorText: signUpController.passwordValidator,
                        controller:
                            signUpController.signUpConfirmPasswordController,
                        onChanged: (value) {
                          signUpController.passwordValidator = null;
                          signUpController.update();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field Required";
                          } else if (signUpController
                                  .signUpPasswordController.text !=
                              signUpController
                                  .signUpConfirmPasswordController.text) {
                            return 'Password does\'nt match';
                          }
                          return null;
                        },
                        suffixIcon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: AppColors.lightGrey,
                        ),
                        suffixIconOnTap: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                        obsecureText: obscureConfirmPassword,
                      ),
                      const SizedBox(height: 16),
                      ButtonWidgetOne(
                        borderRadius: 10,
                        buttonColor: AppColors.primaryColor,
                        buttonText: 'Signup',
                        buttonTextStyle: AppTextStyles.buttonTextStyle1,
                        onTap: () async {
                          ///---keyboard-close
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {
                            loading = !loading;
                          });
                          if (true || _signUpFromKey.currentState!.validate()) {
                            ///loader
                            // generalController.changeLoaderCheck(true);
                            // generalController
                            //     .updateFormLoaderController(true);
                            // signUpController.emailValidator = null;
                            // signUpController.passwordValidator = null;
                            // signUpController.update();
                            // generalController.focusOut(context);
                            await UserAuth().signUpWithEmailAndPassword(
                                context,
                                signUpController.signUpEmailController.text,
                                signUpController.signUpPasswordController.text);

                            // ///post-method
                            // postMethod(
                            //     context,
                            //     signUpWithEmailURL,
                            //     {
                            //       'email': signUpController
                            //           .signUpEmailController.text,
                            //       'first_name': signUpController
                            //           .signUpFirstNameController.text,
                            //       'last_name': signUpController
                            //           .signUpLastNameController.text,
                            //       'password': signUpController
                            //           .signUpPasswordController.text,
                            //       'password_confirmation':
                            //           signUpController
                            //               .signUpConfirmPasswordController
                            //               .text,
                            //       'login_as': "customer",
                            //     },
                            //     true,
                            //     signUpWithEmailRepo);
                          }
                          setState(() {
                            loading = !loading;
                          });
                        },
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () {
                          widget.controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text("Have already account please sign in",
                            style: AppTextStyles.underlineTextStyle1),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppColors.grey)),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Or",
                                style: AppTextStyles.bodyTextStyle7,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.grey)),
                        ],
                      ),
                      SizedBox(height: 18),
                      // ButtonWidgetThree(
                      //   buttonIcon: "assets/icons/Google.png",
                      //   buttonText: "Login Via Google",
                      //   iconHeight: 25,
                      //   onTap: () {},
                      // ),
                      // SizedBox(height: 14),
                      // ButtonWidgetThree(
                      //   buttonIcon: "assets/icons/Facebook.png",
                      //   buttonText: "Login Via Facebook",
                      //   iconHeight: 25,
                      //   onTap: () {
                      //     // Get.find<SigninController>()
                      //     //     .signinWithFacebook();
                      //   },
                      // ),
                      // SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
