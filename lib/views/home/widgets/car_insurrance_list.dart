import 'package:flutter/material.dart';
import 'package:insurrance/src/api/car_inssurance/get_car_type.dart';
import 'package:insurrance/src/model/car_plan.dart';
import 'package:insurrance/views/car_inssurance/offers_view.dart';
// Ensure you import the fetch function

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
        title: Text('Insurance Plans'),
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferListWidget(
                                  carInsurancePlan: plan,
                                )),
                      );
                    },
                    child: ListTile(
                      title: Text(plan.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${plan.price}'),
                          _buildIconRow('Liability to Others',
                              plan.liabilityToOthers ?? ""),
                          _buildIconRow('Defense', plan.defense ?? ""),
                          _buildIconRow('Assistance', plan.assistance ?? ""),
                          _buildIconRow('Coverage', plan.coverage ?? ""),
                          _buildIconRow('Storm', plan.storm ?? ""),
                          _buildIconRow('Terrorism', plan.terrorism ?? ""),
                          _buildIconRow('Breakage', plan.breakage ?? ""),
                          _buildIconRow('Fire', plan.fire ?? ""),
                          _buildIconRow('Theft', plan.theft ?? ""),
                          _buildIconRow(
                              'Compensation', plan.compensation ?? ""),
                          _buildIconRow(
                              'Accident Damage', plan.accidentDamage ?? ""),
                          _buildIconRow(
                              'Extended Breakage', plan.extendedBreakage ?? ""),
                          _buildIconRow('Contents', plan.contents ?? ""),
                          _buildIconRow(
                              'Key Assistance', plan.keyAssistance ?? ""),
                          _buildIconRow('Roadside Assistance 0km',
                              plan.roadsideAssistance0km ?? ""),
                          _buildIconRow('Vehicle Assistance',
                              plan.vehicleAssistance ?? ""),
                          _buildIconRow('Extension', plan.extension ?? ""),
                          _buildIconRow('Redemption', plan.redemption ?? ""),
                          _buildIconRow('Personal Guarantee',
                              plan.personalGuarantee ?? ""),
                        ],
                      ),
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

  Widget _buildIconRow(String label, String value) {
    return Row(
      children: [
        Text('$label: '),
        Icon(
          value == 'coche' ? Icons.check : Icons.close,
          color: value == 'coche' ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
