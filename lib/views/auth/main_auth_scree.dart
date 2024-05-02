import 'package:flutter/material.dart';
import 'package:insurrance/views/auth/login_screen.dart';
import 'package:insurrance/views/auth/signup_screen.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SignupScreen(
              controller: controller,
            );
          } else {
            return SignInScreen(
              controller: controller,
            );
          }
        },
      ),
    );
  }
}
