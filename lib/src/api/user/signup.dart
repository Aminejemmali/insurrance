import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';

Future<String> signUpUser(Map<String, dynamic> userData) async {
  const String endpoint = '/api/clients';
  final Uri url = Uri.parse('$base_url$endpoint');

  try {
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        print('User signed up successfully: ${responseData['data']}');
        return responseData['status'];
      } else {
        print('Failed to sign up user: ${responseData['status']}');
        return responseData['status'];
      }
    } else {
      print('Failed to sign up user: ${response.statusCode}');
      return 'Failed to sign up user: ${response.statusCode}';
    }
  } catch (e) {
    print('Error: $e');
    return 'Error: $e';
  }
}
