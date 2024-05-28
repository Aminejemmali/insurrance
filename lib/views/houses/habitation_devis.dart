import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/src/api/habitation_devis.dart';
import 'package:insurrance/src/providers/user_provideer.dart';
import 'package:intl/intl.dart';
import 'package:insurrance/src/model/habitation_devis.dart';
import 'package:provider/provider.dart';

class HabitationDevisForm extends StatefulWidget {
  final int tarif;
  final int? idtype;

  HabitationDevisForm({required this.tarif, required this.idtype});

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
  bool loading = false;

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
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                //  Text(widget.idtype.toString()),
                  buildTextFormField(
                    controller: _typeLogementController,
                    label: 'Type de Logement',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Type de Logement';
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    controller: _adresseLogementController,
                    label: 'Adresse de Logement',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Adresse de Logement';
                      }
                      return null;
                    },
                  ),
                  buildTextFormField(
                    controller: _dateConstructionController,
                    label: 'Date de Construction (yyyy-MM-dd)',
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
                  buildTextFormField(
                    controller: _dependancesController,
                    label: 'Dépendances',
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        final habitationDevis = HabitationDevis(
                          typeLogement: _typeLogementController.text,
                          adresseLogement: _adresseLogementController.text,
                          dateConstruction: _dateConstructionController.text,
                          surface: double.parse(_surfaceController.text),
                          nbPieces: int.parse(_nbPiecesController.text),
                          dependances: _dependancesController.text,
                          veranda: _veranda,
                          typeId: widget.idtype ?? 1,
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

                        bool sent = await submitHabitationDevis(habitationDevis, context);

                        setState(() {
                          loading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Devis Created Successfully')),
                        );
                      }
                    },
                    child: loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Submit'),
                  ),
                ],
              ),
              if (loading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    void Function()? onTap,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 68.0,
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
}
