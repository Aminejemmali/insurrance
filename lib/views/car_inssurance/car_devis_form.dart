import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insurrance/src/api/car_inssurance/create_devis.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:insurrance/src/services/authentication/stripe/payment_service.dart';
import 'package:intl/intl.dart';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class DevisForm extends StatefulWidget {
  final int tarif;
  final int idtype;
  final int idoffre;
  DevisForm({required this.tarif , required this.idoffre , required this.idtype});
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

  bool loading = false;


  Future<String?> uploadPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child('pdfs/${file.name}');
        UploadTask uploadTask = ref.putFile(File(file.path!));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print('Error uploading file: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Devis Form'),
      ),
      body: LoadingOverlay(
        isLoading: loading,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                buildTextFormField(
                  readOnly: true,
                  controller: _bulletinN3Controller,
                  label: 'Bulletin N3',
                  onTap: () async {
                    String? path = await uploadPDF();
                    if (path != null) {
                      _bulletinN3Controller.text = path;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Bulletin N3';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _immatriculeController,
                  label: 'Immatricule',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Immatricule';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _marqueController,
                  label:  'Marque',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Marque';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _modeleController,
                  label:  'Modèle',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Modèle';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _couleurController,
                  label:  'Couleur',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Couleur';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _carburantController,
                  label: 'Carburant',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Carburant';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _kilometrageAnnuelController,
                  label: 'Kilométrage Annuel',
                  validator: (value) {
                    if ((value == null || value.isEmpty ))  {
                      return 'Please enter Kilométrage Annuel';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _permisController,
                  label:  'Permis',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Permis';
                    }
                    return null;
                  },
                ),
                buildTextFormField(
                  controller: _historiqueDesSinistresController,
                  label: 'Historique des Sinistres',
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
                    // bool done = await PaymentService()
                    //     .handlePayment(context, widget.tarif);
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = !loading;
                      });
                      final carDevis = CarDevis(
                        id: 0,
                        offer_id: widget.idoffre,
                        type_id: widget.idtype,
                        userid: userProvider!.uid,
                        nom: userProvider!.firstName,
                        tarif: widget.tarif.toString(),
                        prenom: userProvider.lastName,
                        email: FirebaseAuth.instance.currentUser!.email!,
                        adresse: userProvider.address ?? " ",
                        codePostale: userProvider.postalCode ?? " ",
                        numTel: userProvider.phoneNumber ?? " ",
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
                        status: false
                      );
                      print(carDevis.toJson());
                      bool sent = await submitCarDevis(carDevis, context);
                      setState(() {
                        loading = !loading;
                      });
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
      ),
    );
  }

  @override
Widget buildTextFormField({
  required String label,
  required TextEditingController controller,
  bool readOnly = false,
  void Function()? onTap,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    height: 82.0,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 197, 147, 30).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          hintText: readOnly ? 'Cliquez pour choisir un fichier' : '',
          suffixIcon: readOnly ? Icon(Icons.lock) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: onTap,
        validator: validator,
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