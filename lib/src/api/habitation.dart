import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/habitation.dart';

  Future<List<Habitation>> fetchHabitations() async {
    final response = await http.get(Uri.parse('$base_url/api/habitations/types'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final habitationData = jsonData['data'] as List<dynamic>;

      List<Habitation> habitationList = habitationData
          .map((habitationJson) => Habitation.fromJson(habitationJson))
          .toList();

      return habitationList;
    } else {
      throw Exception('Failed to fetch habitation list');
    }
  }

