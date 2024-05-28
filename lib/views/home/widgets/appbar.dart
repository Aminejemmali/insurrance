import 'package:flutter/material.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:insurrance/src/services/authentication/auth_firebase.dart';
import 'package:insurrance/views/user_profile/user_profile.dart';
import 'package:resize/resize.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final UserModel userModel;
  const AppBarWidget({
    Key? key, required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Mes Devsies'),
            onTap: () {
             // Navigator.of(context).pushNamed('/services');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () {
             // Navigator.of(context).pushNamed('/settings');
            },
          ),
          Spacer(), // Pushes the user information and logout to the bottom
          Divider(),

          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfileScreen(userModel: userModel,)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              UserAuth().signOut(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
