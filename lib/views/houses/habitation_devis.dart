import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:intl/intl.dart';
import 'package:insurrance/src/model/habitation_devis.dart';
import 'package:provider/provider.dart';

class HabitationDevisForm extends StatefulWidget {
  final int tarif;
  HabitationDevisForm({required this.tarif});
  @override
  _HabitationDevisFormState createState() => _HabitationDevisFormState();
}

class _HabitationDevisFormState extends State<HabitationDevisForm> {
  final _formKey = GlobalKey<FormState>();
  final _typeLogementController = TextEditingController();
  final _adresseLogementController = TextEditingController();
  final _dateConstructionController = TextEditingController();
  final _surfaceController = TextEditingController();
  final _nbPiecesController = TextEditingController();
  final _dependancesController = TextEditingController();
  bool _veranda = false;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Habitation Devis'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _typeLogementController,
                decoration: InputDecoration(labelText: 'Type de Logement'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Type de Logement';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _adresseLogementController,
                decoration: InputDecoration(labelText: 'Adresse de Logement'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Adresse de Logement';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateConstructionController,
                decoration: InputDecoration(
                    labelText: 'Date de Construction (yyyy-MM-dd)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Date de Construction';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _surfaceController,
                decoration: InputDecoration(labelText: 'Surface'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Surface';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nbPiecesController,
                decoration: InputDecoration(labelText: 'Nombre de Pièces'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nombre de Pièces';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dependancesController,
                decoration: InputDecoration(labelText: 'Dépendances'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Dépendances';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Veranda'),
                value: _veranda,
                onChanged: (bool? value) {
                  setState(() {
                    _veranda = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final habitationDevis = HabitationDevis(
                      typeLogement: _typeLogementController.text,
                      adresseLogement: _adresseLogementController.text,
                      dateConstruction: _dateConstructionController.text,
                      surface: double.parse(_surfaceController.text),
                      nbPieces: int.parse(_nbPiecesController.text),
                      dependances: _dependancesController.text,
                      veranda: _veranda,
                      offreId: 0,
                      typeId: 0,
                      clientId: FirebaseAuth.instance.currentUser!.uid,
                      tarif: widget.tarif.toString(),
                      nom: currentUser!.firstName,
                      prenom: currentUser.lastName,
                      email: FirebaseAuth.instance.currentUser!.email!,
                      adresse: currentUser.address ?? " ",
                      codePostale: currentUser.postalCode ?? " ",
                      numTel: currentUser.phoneNumber ?? " ", 
                    );

                    print(habitationDevis.toJson());
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
