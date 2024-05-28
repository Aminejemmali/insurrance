import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/model/user_model.dart'; // Adjust the path as needed

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
      uid: "uid",
      firstName: "firstName",
      lastName: "lastName",
      emailAddress: "emailAddress",
      isActive: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now());

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
