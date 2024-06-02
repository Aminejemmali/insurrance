import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/controllers/general_controller.dart';
import 'package:insurrance/src/controllers/login_controller.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:insurrance/src/widgets/auth_form_field.dart';
import 'package:insurrance/src/widgets/button_widget.dart';
import 'package:insurrance/views/home/index_home.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

class SignInScreen extends StatefulWidget {
  final PageController controller;
  const SignInScreen({super.key, required this.controller});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SigninController signInController;
  bool obscurePassword = true;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    signInController = context.read<SigninController>();
  }

  bool loading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Login Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralController>(
      builder: (context, generalController, _) {
        return GestureDetector(
          onTap: () {
            generalController.focusOut(context);
          },
          child: Consumer<SigninController>(
            builder: (context, signInController, _) {
              return ModalProgressHUD(
                progressIndicator: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                inAsyncCall: generalController.formLoaderController,
                child: ModalProgressHUD(
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
                          key: _loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/sk.png",
                                width: 300,
                                height: 100,
                              ),
                              const Text(
                                "Welcome Back",
                                style: AppTextStyles.bodyTextStyle8,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Sign in to your account",
                                style: AppTextStyles.bodyTextStyle1,
                              ),
                              const SizedBox(height: 28),
                              AuthTextFormFieldWidget(
                                hintText: 'Username / Email',
                                prefixIconColor: AppColors.primaryColor,
                                prefixIcon: "assets/icons/Message.png",
                                controller: signInController.emailController,
                                onChanged: (value) {
                                  signInController.emailValidator = null;
                                  signInController.update();
                                },
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return 'Field Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              AuthPasswordFormFieldWidget(
                                hintText: 'Password',
                                prefixIconColor: AppColors.primaryColor,
                                prefixIcon: "assets/icons/Unlock.png",
                                controller: signInController.passwordController,
                                onChanged: (value) {
                                  signInController.passwordValidator = null;
                                  signInController.update();
                                },
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return 'Field Required';
                                  }
                                  return null;
                                },
                                suffixIconOnTap: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                suffixIcon: Icon(
                                  obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20.h,
                                  color: AppColors.lightGrey,
                                ),
                                obsecureText: obscurePassword,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to forgot password screen
                                    },
                                    child: const Text(
                                      "Forgot Password",
                                      style: AppTextStyles.buttonTextStyle3,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              ButtonWidgetOne(
                                borderRadius: 10,
                                buttonColor: AppColors.primaryColor,
                                buttonText: 'Login',
                                buttonTextStyle: AppTextStyles.buttonTextStyle1,
                                onTap: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    generalController.focusOut(context);
                                    generalController
                                        .updateFormLoaderController(true);
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      AuthResult authResult = await UserAuth()
                                          .signInWithEmailAndPassword(
                                              context,
                                              signInController
                                                  .emailController.text,
                                              signInController
                                                  .passwordController.text);

                                      if (authResult.user != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                        );
                                      } else {
                                        _showErrorDialog(authResult
                                                .errorMessage ??
                                            'An unexpected error occurred.');
                                      }
                                    } catch (e) {
                                      _showErrorDialog(
                                          'An error occurred: ${e.toString()}');
                                    } finally {
                                      setState(() {
                                        loading = false;
                                      });
                                      generalController
                                          .updateFormLoaderController(false);
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 28),
                              GestureDetector(
                                onTap: () {
                                  widget.controller.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: const Text("Create an account",
                                    style: AppTextStyles.underlineTextStyle1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
