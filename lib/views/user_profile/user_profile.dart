import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/api/user/update_user.dart';
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
  final TextEditingController _postalCodeController = TextEditingController();

  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userModel.firstName;
    _lastNameController.text = widget.userModel.lastName;
    _postalCodeController.text = widget.userModel.postalCode ?? "";

    _addressLine1Controller.text = widget.userModel.address ?? '';
    _phoneNumberController.text = widget.userModel.postalCode ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _postalCodeController.dispose();

    _addressLine1Controller.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  bool load = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Consumer<GeneralController>(
      builder: (context, generalController, child) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
          inAsyncCall: load,
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
                        controller: _postalCodeController,
                        decoration: const InputDecoration(
                          hintText: '* Postal code',
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
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ButtonWidgetOne(
                        onTap: () async {
                          if (_firstNameController.text.isEmpty ||
                              _lastNameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Name is required")));
                            return;
                          }
                          setState(() {
                            load = !load;
                          });
                          UserModel userModel = widget.userModel;
                          userModel.firstName = _firstNameController.text;
                          userModel.lastName = _lastNameController.text;
                          userModel.address = _addressLine1Controller.text;
                          userModel.phoneNumber = _phoneNumberController.text;
                          userModel.postalCode = _postalCodeController.text;
                          await updateUserData(userModel);
                          userProvider.setUser(userModel);
                          setState(() {
                            load = !load;
                          });
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
