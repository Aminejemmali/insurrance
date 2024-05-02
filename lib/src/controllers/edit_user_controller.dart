import 'dart:io';

import 'package:flutter/material.dart';

class EditUserProfileController extends ChangeNotifier {
  // GetUserProfileModel getUserProfileModel = GetUserProfileModel(); //  for saving user-profile
  TextEditingController userProfileFirstNameController =
      TextEditingController();
  TextEditingController userProfileLastNameController = TextEditingController();
  TextEditingController userProfilePhoneController = TextEditingController();
  TextEditingController userProfileUserNameController = TextEditingController();
  TextEditingController userProfileDescriptionController =
      TextEditingController();
  TextEditingController userProfileAddressLine1Controller =
      TextEditingController();
  TextEditingController userProfileZipCodeController = TextEditingController();
  String? userProfileSelectedGender;
  DateTime? userProfileSelectedDate;

  File? profileImage;
  String? uploadedProfileImage;
  List profileImagesList = [];

  // DateTime.now().subtract(const Duration(days: 1));

  ///------------------------------- user-profile-data-check
  bool getUserProfileDataCheck = false;
  void update() {
    super.notifyListeners();
  }

  changeGetUserProfileDataCheck(bool value) {
    getUserProfileDataCheck = value;
    notifyListeners();
  }
}
