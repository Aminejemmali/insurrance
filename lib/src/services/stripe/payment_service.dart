import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:insurrance/api.dart';
import 'package:insurrance/src/services/Notifications/notification_services.dart';
import 'package:insurrance/views/devis/devis_list.dart';
import 'package:lottie/lottie.dart';

class StripePayment extends StatefulWidget {
  final int id;
  final String type;
  final int amount;

  StripePayment({super.key, required this.id, required this.type, required this.amount});

  @override
  _StripePaymentState createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  bool _isLoading = true;
  bool _isSuccess = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    startPayment(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment'),
      ),
      body: Stack(
        children: [
          if (_isLoading)
            _buildLoadingAnimation(),
          if (_isSuccess)
            _buildSuccessAnimation(),
          if (_isError)
            _buildFailureAnimation(),
        ],
      ),
    );
  }

  Widget _buildLoadingAnimation() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Lottie.asset('assets/animations/loading.json', width: 400, height: 400),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Lottie.asset('assets/animations/success.json', width: 200, height: 200),
      ),
    );
  }

  Widget _buildFailureAnimation() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Lottie.asset('assets/animations/failure.json', width: 200, height: 200),
      ),
    );
  }

  void startPayment(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _isSuccess = false;
      _isError = false;
    });

    try {
      // Get the clientSecret from your server
      String? clientSecret = await getClientSecretFromServer();

      // Configure the PaymentSheet with the clientSecret
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'SK Assurance',
        ),
      );

      // Display the PaymentSheet
      await Stripe.instance.presentPaymentSheet();
      await updatePaymentStatus(widget.type);

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment completed!')));

      // show Notification For Success Payment
      showPaymentSuccessNotification();

      // Delay for 5 seconds before navigating
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DevisList(),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      handlePaymentError(e);
    }
  }

  void handlePaymentError(Object e) {
    if (e is StripeException) {
      showErrorDialog(context, 'Error from Stripe', e.error.localizedMessage!);
      showPaymentFailureNotification();
    } else {
      showErrorDialog(context, 'Unforeseen error', e.toString());
      showPaymentFailureNotification();
    }
  }

  Future<String?> getClientSecretFromServer() async {
    final url = Uri.parse('$base_url/api/create-payment-intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token', // Replace with your token if your API requires authentication
      },
      body: jsonEncode({
        'amount': widget.amount * 100, // Replace with the desired amount
        'currency': 'eur', // Replace with the desired currency
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['clientSecret'];
    } else {
      throw Exception('Failed to load client secret');
    }
  }

  Future<void> updatePaymentStatus(String type) async {
    final url = Uri.parse('$base_url/api/devis-$type/update-status/${widget.id}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'status': true,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // Handle successful status update if needed
    } else {
      throw Exception('Failed to change payment status');
    }
  }

  Future<void> showPaymentSuccessNotification() async {
    await NotificationService().showNotification(
      widget.id,
      'Payment Success',
      'Payment For Inssurance  ${widget.type} With  Amount ${widget.amount}  EUR.',
    );
  }

  Future<void> showPaymentFailureNotification() async {
    await NotificationService().showNotification(
      widget.id,
      'Payment Failed',
      'Payment For Inssurance  ${widget.type} With  Amount ${widget.amount}  EUR.',
    );
  }

  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
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
