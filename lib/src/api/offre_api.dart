import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/model/offer.dart';

Future<List<Offer>> fetchOffers() async {
  final response = await http.get(Uri.parse('$base_url/api/autos/offres'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body)['data'];
    return jsonData.map((data) => Offer.fromJson(data as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Failed to load offers');
  }
}
