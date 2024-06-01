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
  int _selectedIndex = 0;
  late PageController _pageController;

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
    _pageController = PageController();
    loadDevis();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Devis List'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                ListView.builder(
                  itemCount: habitationDevisList.length,
                  itemBuilder: (context, index) {
                    return buildHabitationDevisCard(habitationDevisList[index]);
                  },
                ),
                ListView.builder(
                  itemCount: carDevisList.length,
                  itemBuilder: (context, index) {
                    return buildCarDevisCard(carDevisList[index]);
                  },
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Habitation Devis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Car Devis',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
