import 'package:flutter/material.dart';
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
  late Future<List<Offer>> futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Extra Offers',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder<List<Offer>>(
        future: futureOffers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No offers available"));
          } else {
            List<Offer> offers = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: offers.length + 1,
              itemBuilder: (context, index) {
                if (index == offers.length) {
                  return InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tapped on extra offer')),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Get an Extra Offer!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                final offer = offers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        offer.name,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${offer.price} €',
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                _showBottomSheet(context, offer);
                              },
                              child: Text('Show Details'),
                            ),
                          ],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                        size: 28,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutWidget(
                              carInsurancePlan: widget.carInsurancePlan,
                              offer: offer,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Offer offer) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Details for ${offer.name}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ..._buildOfferDetails(offer),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildOfferDetails(Offer offer) {
    return offer.attributes.map((attribute) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${attribute.title}:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Text(
              attribute.description.isEmpty ? 'Details set later' : attribute.description,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }
}
