import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insurrance/src/api/user/get_user.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:insurrance/views/auth/main_auth_scree.dart';
import 'package:insurrance/views/home/index_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void> _fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      UserModel? userModel =
          await fetchUserData(FirebaseAuth.instance.currentUser!.uid);
      if (userModel != null && mounted) {
        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        print("loaded user");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          // Ensure the user is logged in
          if (user != null) {
            // Return home
            return const HomeScreen();
          } else {
            // Show auth
            return const MainAuth();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
