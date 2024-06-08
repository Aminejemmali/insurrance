import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/api/user/get_user.dart';
import 'package:insurrance/src/model/user_model.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:insurrance/views/home/widgets/drawer.dart';
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
    super.initState();
     
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(userModel: userProvider.user!),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
                child: HomeBannerSliderWidget(),
              ),

              SizedBox(height: 30),
              Text( 'hi ${userProvider.user!.firstName}'+
                ",  Explore Our Insurance Plans",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 186, 134, 28),
                    ),
              ),
              SizedBox(height: 20),
              InsurranceTypeWidget(
                image_url: 'assets/images/car.png',
                title: "Car Insurance",
                description: "Protect your car with our comprehensive plans.",
                onclick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsurancePlanList()),
                  );
                },
              ),
              SizedBox(height: 30),
              InsurranceTypeWidget(
                image_url: 'assets/images/house.png',
                title: "House Insurance",
                description: "Keep your home safe and secure.",
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
      ),
    );
  }
}
