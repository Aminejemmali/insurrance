import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  Future<bool> handlePayment(BuildContext context, int amount) async {
    //  final paymentIntentData = await createPaymentIntent(context, amount);

    if (true) {
      //paymentIntentData != null) {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: FirebaseAuth
              .instance.currentUser!.uid, //paymentIntentData['client_secret'],
          merchantDisplayName: 'Insurrance',
        ),
      );

      try {
        await Stripe.instance.presentPaymentSheet();
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      BuildContext context, int amount) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': 'usd',
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      showCustomDialog(context, 'Error', e.toString());
      return null;
    }
  }

  void showCustomDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
