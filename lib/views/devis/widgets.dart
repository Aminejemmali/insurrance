import 'package:flutter/material.dart';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:insurrance/src/model/habitation_devis.dart';
import 'package:insurrance/src/services/stripe/payment_service.dart';

Widget buildHabitationDevisCard(HabitationDevis devis , BuildContext context) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${devis.tarif} EUR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Type Logement: ${devis.typeLogement}'),
          Text('Adresse Logement: ${devis.adresseLogement}'),
          Text('Date Construction: ${devis.dateConstruction}'),
          Text('Surface: ${devis.surface} m²'),
          Text('Nombre de Pièces: ${devis.nbPieces}'),
          Text('Dépendances: ${devis.dependances}'),
          Text('Véranda: ${devis.veranda ? 'Oui' : 'Non'}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: devis.status ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      devis.status ? Icons.check_circle : Icons.cancel,
                      color: devis.status ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      devis.status ? 'Payée' : 'Non payée',
                      style: TextStyle(
                        color: devis.status ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),


          if (!devis.status)
            GestureDetector(
              onTap: ()async {

                await Navigator.push(context ,MaterialPageRoute(
                    builder: (context) =>
                        StripePayment(id: devis.id,type: 'habitation', amount: int.parse(devis.tarif),)));},
              child: Image.asset('assets/images/stripe.png', height: 50),
            ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildCarDevisCard(CarDevis devis , BuildContext context) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${devis.tarif} EUR',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Immatricule: ${devis.immatricule}'),
          Text('Marque: ${devis.marque}'),
          Text('Modèle: ${devis.modele}'),
          Text('Couleur: ${devis.couleur}'),
          Text('Carburant: ${devis.carburant}'),
          Text('Kilométrage Annuel: ${devis.kilometrageAnnuel} km'),
          Text('Permis: ${devis.permis}'),
          Text('Historique des Sinistres: ${devis.historiqueDesSinistres}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: devis.status ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      devis.status ? Icons.check_circle : Icons.cancel,
                      color: devis.status ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 8),
                    Text(
                      devis.status ? 'Payée' : 'Non payée',
                      style: TextStyle(
                        color: devis.status ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),


              if (!devis.status)
                GestureDetector(
                  onTap: ()async {

                    await Navigator.push(context ,MaterialPageRoute(
                        builder: (context) =>
                            StripePayment(id: devis.id,type: 'auto', amount: int.parse(devis.tarif),)));},
                  child: Image.asset('assets/images/stripe.png', height: 50),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
