import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/firebase_options.dart';
import 'package:insurrance/src/controllers/edit_user_controller.dart';
import 'package:insurrance/src/controllers/general_controller.dart';
import 'package:insurrance/src/controllers/login_controller.dart';
import 'package:insurrance/src/controllers/signup_controller.dart';
import 'package:insurrance/views/home/index_home.dart';
import 'package:insurrance/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Resize(
        allowtextScaling: true,
        size: const Size(375, 812),
        builder: () {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SignUpController()),
              ChangeNotifierProvider(create: (_) => GeneralController()),
              ChangeNotifierProvider(create: (_) => SigninController()),
              ChangeNotifierProvider(
                  create: (_) => EditUserProfileController()),
            ],
            child: MaterialApp(
              theme: ThemeData(
                //#E0E3E7
                scaffoldBackgroundColor: Color(0xFFF1F4F8),
              ),
              home: Wrapper(),
            ),
          );
        });
  }
}
