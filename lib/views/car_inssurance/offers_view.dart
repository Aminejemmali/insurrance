import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insurrance/src/api/offre_api.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/config/app_text_style.dart';
import 'package:insurrance/src/model/car_plan.dart';
import 'package:insurrance/src/model/offer.dart';
import 'package:insurrance/views/car_inssurance/checkout.dart';

class OfferListWidget extends StatefulWidget {
  final CarInsurancePlan carInsurancePlan;

  const OfferListWidget({
    super.key,
    required this.carInsurancePlan,
  });

  @override
  State<OfferListWidget> createState() => _OfferListWidgetState();
}

class _OfferListWidgetState extends State<OfferListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Offers',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        elevation: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutWidget(
                      carInsurancePlan: widget.carInsurancePlan,
                    ),
                  ),
                );
              },
              child: Text("Skip"))
        ],
      ),
      body: FutureBuilder<List<Offer>>(
        future: fetchOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data found"));
          } else {
            List<Offer> offers = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutWidget(
                            carInsurancePlan: widget.carInsurancePlan,
                            offer: offers[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offers[index].name,
                              style: AppTextStyles.bodyTextStyle1.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Price: ${offers[index].price}',
                              style: AppTextStyles.bodyTextStyle2,
                            ),
                            SizedBox(height: 10),
                            for (var attribute in offers[index].attributes)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  attribute.title,
                                  style: AppTextStyles.bodyTextStyle1,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
