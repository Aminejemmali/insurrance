/*import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';



class Stripe_Payment extends StatefulWidget {
  @override
  _Stripe_Payment createState() => _Stripe_Payment();
}

class _Stripe_Payment extends State<Stripe_Payment> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stripe Payment'),
        ),
        body: Center(
          child: PaymentElementForm(
            key: _formKey,
            autopayMode: PaymentElementAutopayMode.eager,
            paymentMethods: [
              PaymentIntentsPaymentMethod.card(),
            ],
            merchantConfiguration: MerchantConfiguration(
              publishableKey: Stripe.publishableKey,
              appleMerchantIdentifier: 'YOUR_APPLE_MERCHANT_IDENTIFIER', // For iOS
            ),
          ),
        ),
      ),
    );
  }
}*/