import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/api/get_devis_list.dart';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:insurrance/src/model/habitation_devis.dart';
import 'package:insurrance/views/devis/widgets.dart';

class DevisList extends StatefulWidget {
  const DevisList({super.key});

  @override
  State<DevisList> createState() => _DevisListState();
}

class _DevisListState extends State<DevisList> {
  List<HabitationDevis> habitationDevisList = [];
  List<CarDevis> carDevisList = [];
  bool isLoading = true;
  Future<void> loadDevis() async {
    try {
      final data = await fetchDevis(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        habitationDevisList = data['habitationDevis'];
        carDevisList = data['carDevis'];
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load devis: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDevis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devis List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                if (index < habitationDevisList.length) {
                  return buildHabitationDevisCard(habitationDevisList[index]);
                } else {
                  final carIndex = index - habitationDevisList.length;
                  return buildCarDevisCard(carDevisList[carIndex]);
                }
              },
              separatorBuilder: (context, index) =>
                  Divider(), 
              itemCount: habitationDevisList.length + carDevisList.length,
            ),
    );
  }
}
