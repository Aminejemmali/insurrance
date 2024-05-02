import 'package:flutter/material.dart';

class SigninController extends ChangeNotifier {
  String? emailValidator;
  String? passwordValidator;

  // GetSignInUserModel signInUserModel =
  //     GetSignInUserModel(); //  for saving login-data

  final GlobalKey<FormState> _loginFromKey = GlobalKey();
  GlobalKey<FormState> get loginFromKey => _loginFromKey;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void update() {
    super.notifyListeners();
  }
}
  /// Signin with Facebook
  // Future<void> signinWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance
  //         .login(permissions: ["email", "public_profile"]);
  //     if (result.accessToken == null) return;
  //     if (result.status == LoginStatus.success) {
  //       Map<String, dynamic> userData = await FacebookAuth.instance.getUserData(
  //           fields: "email,first_name,last_name,picture.width(200)");

  //       postMethod(
  //           Get.context!,
  //           socialLoginURL,
  //           {
  //             'email': userData["email"],
  //             'first_name': userData["first_name"],
  //             'last_name': userData["last_name"],
  //             'login_as': "customer",
  //             // 'id': userData["id"],
  //           },
  //           false,
  //           socialSignInWithEmailRepo);
  //     }
  //   } on PlatformException catch (e) {
  //     log("Error: ${e.toString()}");
  //   } on SocketException catch (e) {
  //     log("Error: ${e.toString()}");
  //   }
  // }

  // /// Signin with Google
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await GoogleSignIn().signIn();

  //     final GoogleSignInAuthentication? googleSignInAuthentication =
  //         await googleSignInAccount?.authentication;
  //     if (googleSignInAuthentication?.accessToken == null) {
  //       return;
  //     }

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication?.accessToken,
  //       idToken: googleSignInAuthentication?.idToken,
  //     );

  //     final UserCredential authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final user = authResult.user;

  //     postMethod(
  //         Get.context!,
  //         socialLoginURL,
  //         {
  //           'email': user!.email,
  //           'first_name': user.displayName,
  //           'last_name': user.displayName,
  //           'login_as': "customer",
  //         },
  //         false,
  //         socialSignInWithEmailRepo);
  //   } catch (e) {
  //     print('Google Login Error: $e');
  //   }
  // }

