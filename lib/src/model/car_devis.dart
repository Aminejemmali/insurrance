class CarDevis {
  final String nom;
  final String tarif;
  final String prenom;
  final String email;
  final String adresse;
  final String codePostale;
  final String numTel;
  final String bulletinN3;
  final String immatricule;
  final String marque;
  final String modele;
  final String couleur;
  final String carburant;
  final String kilometrageAnnuel;
  final String permis;
  final String historiqueDesSinistres;

  CarDevis({
    required this.nom,
    required this.tarif,
    required this.prenom,
    required this.email,
    required this.adresse,
    required this.codePostale,
    required this.numTel,
    required this.bulletinN3,
    required this.immatricule,
    required this.marque,
    required this.modele,
    required this.couleur,
    required this.carburant,
    required this.kilometrageAnnuel,
    required this.permis,
    required this.historiqueDesSinistres,
  });

  factory CarDevis.fromJson(Map<String, dynamic> json) {
    return CarDevis(
      nom: json['nom'] ?? '',
      tarif: json['tarif'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      adresse: json['adresse'] ?? '',
      codePostale: json['code_postale'] ?? '',
      numTel: json['num_tel'] ?? '',
      bulletinN3: json['Bulletin_n3'] ?? '',
      immatricule: json['immatricule'] ?? '',
      marque: json['marque'] ?? '',
      modele: json['modele'] ?? '',
      couleur: json['couleur'] ?? '',
      carburant: json['carburant'] ?? '',
      kilometrageAnnuel: json['Kilometrage_annuel'] ?? '',
      permis: json['permis'] ?? '',
      historiqueDesSinistres: json['Historique_des_sinistres'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'tarif': tarif,
      'prenom': prenom,
      'email': email,
      'adresse': adresse,
      'code_postale': codePostale,
      'num_tel': numTel,
      'Bulletin_n3': bulletinN3,
      'immatricule': immatricule,
      'marque': marque,
      'modele': modele,
      'couleur': couleur,
      'carburant': carburant,
      'Kilometrage_annuel': kilometrageAnnuel,
      'permis': permis,
      'Historique_des_sinistres': historiqueDesSinistres,
    };
  }
}
