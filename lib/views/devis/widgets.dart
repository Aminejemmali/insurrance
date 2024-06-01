import 'package:flutter/material.dart';
import 'package:insurrance/src/model/car_devis.dart';
import 'package:insurrance/src/model/habitation_devis.dart';

Widget buildHabitationDevisCard(HabitationDevis devis) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${devis.tarif} USD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Type Logement: ${devis.typeLogement}'),
          Text('Adresse Logement: ${devis.adresseLogement}'),
          Text('Date Construction: ${devis.dateConstruction}'),
          Text('Surface: ${devis.surface} m²'),
          Text('Nombre de Pièces: ${devis.nbPieces}'),
          Text('Dépendances: ${devis.dependances}'),
          Text('Véranda: ${devis.veranda ? 'Oui' : 'Non'}'),
        ],
      ),
    ),
  );
}

Widget buildCarDevisCard(CarDevis devis) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${devis.tarif} USD',
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
        ],
      ),
    ),
  );
}
