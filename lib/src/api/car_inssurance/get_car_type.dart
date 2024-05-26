import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/car_plan.dart';

Future<List<CarInsurancePlan>> fetchInsurancePlans() async {
  final response = await http.get(Uri.parse('$base_url/api/autos/types'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    final List<dynamic> jsonData = jsonResponse['data'];


    return jsonData.map((data) => CarInsurancePlan.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load insurance plans');
  }
}
