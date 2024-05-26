import 'package:flutter/material.dart';
import 'package:insurrance/views/home/widgets/appbar.dart';
import 'package:insurrance/views/home/widgets/banner_slider.dart';
import 'package:insurrance/views/home/widgets/car_insurrance_list.dart';
import 'package:insurrance/views/home/widgets/insurance_types.dart';
import 'package:insurrance/views/home/widgets/search_filter_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isLawyerListSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 20), // Adjusted padding values
              child: HomeBannerSliderWidget(),
            ),
            SearchFilterWidget(
              onSearchTap: () {},
              controller: TextEditingController(),
            ),
            SizedBox(height: 20), // Added sized box for better spacing
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
            SizedBox(height: 20), // Added sized box for better spacing
            InsurranceTypeWidget(
              image_url: 'assets/images/house.png',
              title: "House Insurrance",
              onclick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
