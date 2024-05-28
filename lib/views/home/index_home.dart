import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/api/user/get_user.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:insurrance/views/home/widgets/appbar.dart';
import 'package:insurrance/views/home/widgets/banner_slider.dart';
import 'package:insurrance/views/car_inssurance/car_insurrance_list.dart';
import 'package:insurrance/views/home/widgets/insurance_types.dart';
import 'package:insurrance/views/home/widgets/search_filter_widget.dart';
import 'package:insurrance/views/houses/houses_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isLawyerListSelected = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    print(userProvider.user!.firstName);
    return Scaffold(
      appBar: AppBarWidget(
        userModel: userProvider.user!,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
              child: HomeBannerSliderWidget(),
            ),
            SearchFilterWidget(
              onSearchTap: () {},
              controller: TextEditingController(),
            ),
            SizedBox(height: 20),
            InsurranceTypeWidget(
              image_url: 'assets/images/car.png',
              title: "Cars Insurrance",
              onclick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsurancePlanList()),
                );
              },
            ),
            SizedBox(height: 20),
            InsurranceTypeWidget(
              image_url: 'assets/images/house.png',
              title: "House Insurrance",
              onclick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HabitationPlans()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
