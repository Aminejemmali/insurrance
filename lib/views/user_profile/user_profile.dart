import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/controllers/edit_user_controller.dart';
import 'package:insurrance/src/controllers/general_controller.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:insurrance/src/widgets/app_bar_widget.dart';
import 'package:insurrance/src/widgets/button_widget.dart';

import 'package:insurrance/src/widgets/text_form_widget.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<FormState> _userProfileUpdateFormKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralController>(
        builder: (context, generalController, child) {
      return Consumer<EditUserProfileController>(
          builder: (context, editUserProfileController, child) {
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
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: AppBarWidget(
                    richTextSpan: const TextSpan(
                      text: 'Profile',
                      style: AppTextStyles.appbarTextStyle2,
                      children: <TextSpan>[],
                    ),
                    leadingIcon: "assets/icons/Expand_left.png",
                    leadingOnTap: () {
                      UserAuth().signOut(context);
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    child: Form(
                      key: _userProfileUpdateFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColors.gradientOne,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      imagePickerDialog(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.offWhite,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.primaryColor)),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/icons/Upload_duotone_line.png"),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "Upload image",
                                            style: AppTextStyles.bodyTextStyle1,
                                          )
                                        ],
                                      ),
                                    )),
                                const SizedBox(width: 16),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "",
                                      style: AppTextStyles.bodyTextStyle5,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "",
                                      style: AppTextStyles.bodyTextStyle6,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          TextFormFieldWidget(
                            hintText: '* First Name',
                            controller: editUserProfileController
                                .userProfileFirstNameController,
                            // initialText: editUserProfileLogic
                            //     .userProfileFirstNameController.text,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileFirstNameController.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First Name Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormFieldWidget(
                            hintText: '* Last Name',
                            controller: editUserProfileController
                                .userProfileLastNameController,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileLastNameController.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Last Name Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormFieldWidget(
                            hintText: '* User Name',
                            controller: editUserProfileController
                                .userProfileUserNameController,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileUserNameController.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'User Name Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormFieldWidget(
                            hintText: '* Description',
                            controller: editUserProfileController
                                .userProfileDescriptionController,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileDescriptionController.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Description Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormFieldWidget(
                            hintText: '* Address Line 1',
                            controller: editUserProfileController
                                .userProfileAddressLine1Controller,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileAddressLine1Controller.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Address Line 1 Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormFieldWidget(
                            hintText: '* Zip Code',
                            controller: editUserProfileController
                                .userProfileZipCodeController,
                            onChanged: (String? value) {
                              editUserProfileController
                                      .userProfileZipCodeController.text ==
                                  value;
                              editUserProfileController.update();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Zip Code Field Required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          ButtonWidgetOne(
                              onTap: () async {},
                              buttonText: "Save Profile",
                              buttonTextStyle: AppTextStyles.bodyTextStyle8,
                              borderRadius: 10,
                              buttonColor: AppColors.primaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      });
    });
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {},
                  child: Text(
                    'camera',
                    style: AppTextStyles.buttonTextStyle8,
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {},
                  child: Text(
                    'gallery',
                    style: AppTextStyles.buttonTextStyle8,
                  )),
            ],
          );
        });
  }
}
