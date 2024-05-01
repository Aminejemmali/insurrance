import 'package:flutter/material.dart';

import 'package:resize/resize.dart';


import '../config/app_colors.dart';



class AppBarWidget extends StatelessWidget {
  final TextSpan richTextSpan;
  final String leadingIcon;
  final Widget? profileImage;
  // final Widget? actionsIconWidget;

  final VoidCallback leadingOnTap;
  const AppBarWidget({
    super.key,
    required this.richTextSpan,
    required this.leadingIcon,
    this.profileImage,
    required this.leadingOnTap,

    // this.actionsIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: leadingOnTap,
        child: Image.asset(
          leadingIcon,
          scale: 1.5.h,
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            InkWell(
              onTap:
             (){},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                child:  Image.asset(
                            "assets/icons/user-avatar.png",
                            height: 32.h,
                          )
                    
              ),
            ),
          ],
        )
      ],
      title: RichText(
        textAlign: TextAlign.center,
        softWrap: true,
        text: richTextSpan,
      ),
      backgroundColor: AppColors.white,
      elevation: 0,
    );
  }
}
