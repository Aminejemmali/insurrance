import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
    uid: "uid",
    firstName: "loading",
    lastName: "loading",
    emailAddress: "emailAddress",
    isActive: true,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  );

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> fetchUserData(String userId) async {
    final String url = '$base_url/api/clients/$userId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          _user = UserModel.fromJson(responseData['data']);
          notifyListeners();
        } else {
          throw Exception('Error: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
