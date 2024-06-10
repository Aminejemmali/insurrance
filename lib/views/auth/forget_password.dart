import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/widgets/auth_form_field.dart';
import 'package:insurrance/src/widgets/button_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../src/config/app_text_style.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool boolValue = false;
  bool obscurePassword = true;

  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        inAsyncCall: loading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Reset Password"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 58, 18, 0),
              child: Form(
                key: _forgotPasswordFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 28),
                    const Text(
                      "Forgot your password?",
                      style: AppTextStyles.bodyTextStyle8,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "we're excited to welcome you to our community!",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyTextStyle1,
                    ),
                    const SizedBox(height: 28),
                    AuthTextFormFieldWidget(
                      hintText: 'Email',
                      prefixIconColor: AppColors.primaryColor,
                      prefixIcon: "assets/icons/Message.png",
                      controller: _emailController,
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return 'Email is Required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ButtonWidgetOne(
                      borderRadius: 10,
                      buttonColor: AppColors.primaryColor,
                      buttonText: 'Submit',
                      buttonTextStyle: AppTextStyles.buttonTextStyle1,
                      onTap: () async {
                        //! todo
                        setState(() {
                          loading = !loading;
                        });

                        if (_emailController.text.isNotEmpty &&
                            _emailController.text.contains("@")) {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text);
                        }
                        setState(() {
                          loading = !loading;
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password reset email sent")));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
