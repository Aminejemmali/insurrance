import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'dart:convert';

import 'package:insurrance/src/model/devis.dart';

Future<bool> submitCarDevis(CarDevis carDevis) async {
  final url = Uri.parse('$base_url/api/autos/create-devis');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(carDevis.toJson()),
    );

    if (response.statusCode == 200) {
      print("sent");
      return true;
    } else {
      print('Failed to submit devis: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error submitting devis: $e');
    return false;
  }
}
