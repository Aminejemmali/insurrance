import 'package:flutter/material.dart';
import 'package:insurrance/src/api/habitation.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/model/habitation.dart';
import 'package:insurrance/views/houses/habitation_checkout.dart';

class HabitationPlans extends StatefulWidget {
  @override
  _HabitationPlansState createState() => _HabitationPlansState();
}

class _HabitationPlansState extends State<HabitationPlans> {
  late Future<List<Habitation>> futurePlans;

  @override
  void initState() {
    super.initState();
    futurePlans = fetchHabitations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Offer',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder<List<Habitation>>(
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
                  margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        plan.nom,
                        style: TextStyle(
                          fontSize: 22.0,
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
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${plan.tarif} €',
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              'More Info:',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showBottomSheet(context, plan);
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
                            builder: (context) => HabitationCheckout(
                              habitation: plan,
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

  void _showBottomSheet(BuildContext context, Habitation plan) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Details for ${plan.nom}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ..._buildPlanDetails(plan),
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

  List<Widget> _buildPlanDetails(Habitation plan) {
    return [
      _buildIconRow('Responsabilité', plan.responsabilite ? "coche" : ""),
      _buildIconRow('Défense', plan.defense ? "coche" : ""),
      _buildIconRow('Incendie', plan.incendie ? "coche" : ""),
      _buildIconRow('Dégâts', plan.degats ? "coche" : ""),
      _buildIconRow('Événement Climatique', plan.evenementClimatique ? "coche" : ""),
      _buildIconRow('Catastrophes', plan.catastrophes ? "coche" : ""),
      _buildIconRow('Attentats', plan.attentas ? "coche" : ""),
      _buildIconRow('Assistance', plan.assistance ? "coche" : ""),
      _buildIconRow('Bris', plan.bris ? "coche" : ""),
      _buildIconRow('Vol Vandalisme', plan.volVandalisme ? "coche" : ""),
      _buildIconRow('Vol Casse', plan.volCasse ? "coche" : ""),
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
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Icon(
            value == 'coche' ? Icons.check_circle : Icons.cancel,
            color: value == 'coche' ? Colors.green : Colors.red,
            size: 22,
          ),
        ],
      ),
    );
  }
}
