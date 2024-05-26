import 'package:flutter/material.dart';
import 'package:insurrance/src/api/car_inssurance/get_car_type.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/model/car_plan.dart';
import 'package:insurrance/views/car_inssurance/offers_view.dart';

class InsurancePlanList extends StatefulWidget {
  @override
  _InsurancePlanListState createState() => _InsurancePlanListState();
}

class _InsurancePlanListState extends State<InsurancePlanList> {
  late Future<List<CarInsurancePlan>> futurePlans;

  @override
  void initState() {
    super.initState();
    futurePlans = fetchInsurancePlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Offer',
          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<CarInsurancePlan>>(
        future: futurePlans,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final plan = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        plan.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '\$${plan.price}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            ..._buildPlanDetails(plan),
                          ],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfferListWidget(
                              carInsurancePlan: plan,
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

  List<Widget> _buildPlanDetails(CarInsurancePlan plan) {
  return [
    _buildIconRow('Liability to Others', plan.liabilityToOthers ?? ""),
    _buildIconRow('Defense', plan.defense ?? ""),
    _buildIconRow('Assistance', plan.assistance ?? ""),
    _buildIconRow('Coverage', plan.coverage ?? ""),
    _buildIconRow('Storm', plan.storm ?? ""),
    _buildIconRow('Terrorism', plan.terrorism ?? ""),
    _buildIconRow('Breakage', plan.breakage ?? ""),
    _buildIconRow('Fire', plan.fire ?? ""),
    _buildIconRow('Theft', plan.theft ?? ""),
    _buildIconRow('Compensation', plan.compensation ?? ""),
    _buildIconRow('Accident Damage', plan.accidentDamage ?? ""),
    _buildIconRow('Extended Breakage', plan.extendedBreakage ?? ""),
    _buildIconRow('Contents', plan.contents ?? ""),
    _buildIconRow('Key Assistance', plan.keyAssistance ?? ""),
    _buildIconRow('Roadside Assistance 0km', plan.roadsideAssistance0km ?? ""),
    _buildIconRow('Vehicle Assistance', plan.vehicleAssistance ?? ""),
    _buildIconRow('Extension', plan.extension ?? ""),
    _buildIconRow('Redemption', plan.redemption ?? ""),
    _buildIconRow('Personal Guarantee', plan.personalGuarantee ?? ""),
  ];
}


  Widget _buildIconRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Icon(
            value == 'coche' ? Icons.check_circle : Icons.cancel,
            color: value == 'coche' ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}
