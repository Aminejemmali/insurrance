import 'dart:convert';

import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:http/http.dart' as http;

Future<UserModel?> fetchUserData(String userId) async {
  final String url = '$base_url/api/clients/$userId';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        print("success");
        return UserModel.fromJson(responseData['data']);
      } else {
        print('Error: ${responseData['message']}');
        return null;
      }

    } else {
      print('Failed to load user data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
