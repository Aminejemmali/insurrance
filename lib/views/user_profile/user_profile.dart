import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/controllers/general_controller.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:insurrance/src/widgets/button_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const UserProfileScreen({super.key, required this.userModel});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userModel.firstName;
    _lastNameController.text = widget.userModel.lastName;
    _userNameController.text = widget.userModel.emailAddress;

    _addressLine1Controller.text = widget.userModel.address ?? '';
    _zipCodeController.text = widget.userModel.postalCode ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();

    _addressLine1Controller.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralController>(
      builder: (context, generalController, child) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
          inAsyncCall: generalController.formLoaderController,
          child: GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Your Profile"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: '* First Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: '* Last Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _userNameController,
                        decoration: const InputDecoration(
                          hintText: '* User Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _addressLine1Controller,
                        decoration: const InputDecoration(
                          hintText: '* Address Line 1',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _zipCodeController,
                        decoration: const InputDecoration(
                          hintText: '* Zip Code',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ButtonWidgetOne(
                        onTap: () {
                          // Handle button tap
                        },
                        buttonText: "Save Profile",
                        buttonTextStyle: AppTextStyles.bodyTextStyle8,
                        borderRadius: 10,
                        buttonColor: AppColors.primaryColor,
                      ),
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
