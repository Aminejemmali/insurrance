import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/user_model.dart';

Future<bool> updateUserData(UserModel user) async {
  final String url = '$base_url/api/clients/${user.uid}';

  final Map<String, dynamic> userData = {
    'prenom': user.firstName,
    'nom': user.lastName,
    'email': user.emailAddress,
    'adresse': user.address,
    'num_tel': user.phoneNumber,
    'code_postale': user.postalCode,
    'isActive': user.isActive,
    'updated_at': DateTime.now().toIso8601String(),
  };

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        print("User data updated successfully");
        return true;
      } else {
        print('Error: ${responseData['message']}');
        return false;
      }
    } else {
      print('Failed to update user data. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
