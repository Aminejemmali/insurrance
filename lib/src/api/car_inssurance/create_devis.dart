import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'dart:convert';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:insurrance/views/car_inssurance/check_done.dart';
import 'package:insurrance/views/home/index_home.dart';
Future<bool> submitCarDevis(CarDevis carDevis , BuildContext context) async {
  final url = Uri.parse('$base_url/api/autos/create-devis');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(carDevis.toJson()),
    );

   if (response.statusCode == 201) {
  print("Success");
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Devis has been successfully created.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the alert dialog
              Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AppointmentBookedPage(
                                            
                                          )));
            },
          ),
        ],
      );
    },
  );
  return true;
} else {
  print('Failed to submit devis: ${response.statusCode}');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Failed to create the devis. Please try again.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(), // Just close the dialog
          ),
        ],
      );
    },
  );
  return false;
}

  } catch (e) {
    print('Error submitting devis: $e');
    return false;
  }
}
