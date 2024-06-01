import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:insurrance/src/model/habitation_devis.dart';

Future<Map<String, dynamic>> fetchDevis(String uid) async {
  //uid = "wcXqMsTiVmPrjiYQKzshghq51hu2";
  final response = await http.get(Uri.parse('$base_url/api/mes-devis/$uid'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    final List<dynamic> habitationDevisJson = data['devis_habitation'];
    final List<dynamic> carDevisJson = data['devis_auto'];

    final List<HabitationDevis> habitationDevisList = habitationDevisJson
        .map((json) => HabitationDevis.fromJson(json))
        .toList();
    final List<CarDevis> carDevisList =
        carDevisJson.map((json) => CarDevis.fromJson(json)).toList();

    return {
      'habitationDevis': habitationDevisList,
      'carDevis': carDevisList,
    };
  } else {
    throw Exception('Failed to load devis');
  }
}
