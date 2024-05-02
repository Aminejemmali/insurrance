import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

import '../config/app_colors.dart';


class GeneralController extends ChangeNotifier {

 int bottomNavIndex = 1;
  bool formLoaderController = false;

  updateBottomNavIndex(int newValue) {
    bottomNavIndex = newValue;
    notifyListeners();
  }

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    notifyListeners();
  }

  bool callLoaderController = false;

  updateCallLoaderController(bool newValue) {
    callLoaderController = newValue;
    notifyListeners();
  }
focusOut(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  final String countryCode;

  Language(this.id, this.name, this.flag, this.languageCode, this.countryCode);
}
