import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:resize/resize.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // leading: InkWell(
      //   onTap: (){},
      //   child: Image.asset(
      //     'assets/icons/user-avatar.png',
      //     scale: 1.5.h,
      //   ),
      // ),
      actions: <Widget>[
        Row(
          children: [
            InkWell(
              onTap: () {
                UserAuth().signOut(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                child: Image.asset(
                  "assets/icons/user-avatar.png",
                  height: 32.h,
                ),
              ),
            ),
          ],
        )
      ],
      title: RichText(
        textAlign: TextAlign.center,
        softWrap: true,
        text: const TextSpan(
          text: 'Insurance',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
