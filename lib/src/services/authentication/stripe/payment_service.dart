import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentSheetDefferedScreen extends StatefulWidget {
  @override
  _PaymentSheetDefferedScreenState createState() => _PaymentSheetDefferedScreenState();
}

class _PaymentSheetDefferedScreenState extends State<PaymentSheetDefferedScreen> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment '),
      ),
      body: Center(
        child: step == 0
            ? ElevatedButton(
          onPressed: initPaymentSheet,
          child: Text('Initialize Payment Sheet'),
        )
            : ElevatedButton(
          onPressed: confirmPayment,
          child: Text('Confirm Payment'),
        ),
      ),
    );
  }


  Future<void> initPaymentSheet() async {
    try {
      // Create some billing details
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'FR',
          line1: '1459 Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      );

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flutter Stripe Store Demo',
          intentConfiguration: IntentConfiguration(
            mode: IntentMode(
              currencyCode: 'USD',
              amount: 1500,
            ),
            /*  confirmHandler: (method, saveFuture) {
              _createIntentAndConfirmToUser(method.id);
            },*/
          ),
          primaryButtonLabel: 'Pay now',
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'DE',
            testEnv: true,
          ),
          style: ThemeMode.dark,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.lightBlue,
              primary: Colors.blue,
              componentBorder: Colors.red,
            ),
            shapes: PaymentSheetShape(
              borderWidth: 4,
              shadow: PaymentSheetShadowParams(color: Colors.red),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 235, 92, 30),
                  border: Color.fromARGB(255, 235, 92, 30),
                ),
              ),
            ),
          ),
          billingDetails: billingDetails,
        ),
      );
      setState(() {
        step = 1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }


  Future<void> confirmPayment() async {
    try {
      // Assuming you have a Stripe instance configured
      // (and potentially using stripe_platform for Stripe 10+)
      final paymentResult = await Stripe.instance.presentPaymentSheet();
/*
      if (paymentResult.isCompleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment successfully completed.'),
          ),
        );
      } else {
        // Handle other statuses like canceled or failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment not completed. Status: ${paymentResult?.status}'),
          ),
        );
      }
*/
      setState(() {
        step = 0;  // Reset the payment step
      });
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error from Stripe: ${e.error.localizedMessage}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unforeseen error: $e'),
        ),
      );
    }
  }

}