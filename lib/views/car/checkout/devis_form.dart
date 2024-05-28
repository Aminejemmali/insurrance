import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/services/authentication/stripe/payment_service.dart';
import 'package:intl/intl.dart';
import 'package:insurrance/src/model/devis.dart';

class DevisForm extends StatefulWidget {
  final int tarif;
  DevisForm({required this.tarif});
  @override
  _DevisFormState createState() => _DevisFormState();
}

class _DevisFormState extends State<DevisForm> {
  final _formKey = GlobalKey<FormState>();
  final _bulletinN3Controller = TextEditingController();
  final _immatriculeController = TextEditingController();
  final _marqueController = TextEditingController();
  final _modeleController = TextEditingController();
  final _couleurController = TextEditingController();
  final _carburantController = TextEditingController();
  final _kilometrageAnnuelController = TextEditingController();
  final _permisController = TextEditingController();
  final _historiqueDesSinistresController = TextEditingController();
  final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devis Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _bulletinN3Controller,
                decoration: InputDecoration(labelText: 'Bulletin N3'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Bulletin N3';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _immatriculeController,
                decoration: InputDecoration(labelText: 'Immatricule'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Immatricule';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _marqueController,
                decoration: InputDecoration(labelText: 'Marque'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Marque';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modeleController,
                decoration: InputDecoration(labelText: 'Modèle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Modèle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _couleurController,
                decoration: InputDecoration(labelText: 'Couleur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Couleur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _carburantController,
                decoration: InputDecoration(labelText: 'Carburant'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Carburant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kilometrageAnnuelController,
                decoration: InputDecoration(labelText: 'Kilométrage Annuel'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Kilométrage Annuel';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _permisController,
                decoration: InputDecoration(labelText: 'Permis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Permis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _historiqueDesSinistresController,
                decoration:
                    InputDecoration(labelText: 'Historique des Sinistres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Historique des Sinistres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool done = await PaymentService()
                      .handlePayment(context, widget.tarif);
                  if (_formKey.currentState!.validate()) {
                    final devis = CarDevis(
                      nom: '',
                      tarif: '',
                      prenom: '',
                      email: FirebaseAuth.instance.currentUser!.email!,
                      adresse: '',
                      codePostale: '',
                      numTel: '',
                      bulletinN3: _bulletinN3Controller.text,
                      immatricule: _immatriculeController.text,
                      marque: _marqueController.text,
                      modele: _modeleController.text,
                      couleur: _couleurController.text,
                      carburant: _carburantController.text,
                      kilometrageAnnuel: _kilometrageAnnuelController.text,
                      permis: _permisController.text,
                      historiqueDesSinistres:
                          _historiqueDesSinistresController.text,
                    );

                    print('Devis created: ${devis.toJson()}');

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Devis Created Successfully')),
                    );
                  }
                },
                child: Text('Pay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bulletinN3Controller.dispose();
    _immatriculeController.dispose();
    _marqueController.dispose();
    _modeleController.dispose();
    _couleurController.dispose();
    _carburantController.dispose();
    _kilometrageAnnuelController.dispose();
    _permisController.dispose();
    _historiqueDesSinistresController.dispose();
    super.dispose();
  }
}
