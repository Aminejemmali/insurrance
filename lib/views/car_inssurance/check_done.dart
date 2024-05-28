import 'package:flutter/material.dart';
import 'package:insurrance/views/home/index_home.dart';

class AppointmentBookedPage extends StatefulWidget {
  const AppointmentBookedPage({super.key});

  @override
  State<AppointmentBookedPage> createState() => _AppointmentBookedPageState();
}

class _AppointmentBookedPageState extends State<AppointmentBookedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 100),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/thumb_success.png'),
              const SizedBox(
                height: 60,
              ),
              const Text(
                'thank you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Devis created',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const Expanded(
                child: SizedBox(
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  text: "Done",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double elevation;
  final double borderRadius;
  final EdgeInsets? padding;
  final double? textSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.elevation = 0,
    this.borderRadius = 4,
    this.padding,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize: textSize ??
                      Theme.of(context).textTheme.labelLarge!.fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
