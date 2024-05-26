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
    Key? key,
    required this.carInsurancePlan,
  }) : super(key: key);

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
          'Select Extra Offers',
          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutWidget(
                    carInsurancePlan: widget.carInsurancePlan,
                  ),
                ),
              );
            },
            tooltip: 'Skip to checkout',
          ),
        ],
      ),
      body: FutureBuilder<List<Offer>>(
        future: fetchOffers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No offers available"));
          } else {
            List<Offer> offers = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: offers.length + 1, // Add one for the extra offer card
              itemBuilder: (context, index) {
                if (index == offers.length) {
                  // Render the extra offer card
                  return InkWell(
                    onTap: () {
                      // Placeholder action for the extra offer card
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tapped on extra offer')),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Get an Extra Offer!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return InkWell(
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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
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
                          const SizedBox(height: 8),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 500),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red[800], // Bright red for visibility
                              fontWeight: FontWeight.bold,
                            ),
                            child: Text('Price: \$${offers[index].price}'),
                          ),
                          const SizedBox(height: 10),
                          ...offers[index].attributes.map((attribute) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "${attribute.title}: ${attribute.description}",
                              style: AppTextStyles.bodyTextStyle1,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
        },
      ),
    );
  }
}
