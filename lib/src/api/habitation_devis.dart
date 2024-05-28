import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:insurrance/src/model/habitation_devis.dart';

Future<bool> submitHabitationDevis(HabitationDevis habitationDevis) async {
  final url = Uri.parse('{{base_url}}/api/habitations/create-devis');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(habitationDevis.toJson()),
    );

    if (response.statusCode == 200) {
      print("Data sent successfully");
      return true;
    } else {
      print('Failed to submit data: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error submitting data: $e');
    return false;
  }
}
