class HabitationDevis {
  final String tarif;
  final String nom;
  final String prenom;
  final String email;
  final String adresse;
  final String codePostale;
  final String numTel;
  final String typeLogement;
  final String adresseLogement;
  final String dateConstruction;
  final double surface;
  final int nbPieces;
  final String dependances;
  final bool veranda;
  final int offreId;
  final int typeId;
  final String clientId;

  HabitationDevis({
    required this.tarif,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.adresse,
    required this.codePostale,
    required this.numTel,
    required this.typeLogement,
    required this.adresseLogement,
    required this.dateConstruction,
    required this.surface,
    required this.nbPieces,
    required this.dependances,
    required this.veranda,
    required this.offreId,
    required this.typeId,
    required this.clientId,
  });

  factory HabitationDevis.fromJson(Map<String, dynamic> json) {
    return HabitationDevis(
      tarif: json['tarif'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      adresse: json['adresse'],
      codePostale: json['code_postale'],
      numTel: json['num_tel'],
      typeLogement: json['type_logement'],
      adresseLogement: json['adresse_logement'],
      dateConstruction: json['date_construcion'],
      surface: json['surface'],
      nbPieces: json['nb_pieces'],
      dependances: json['dependances'],
      veranda: json['veranda'],
      offreId: json['offre_id'],
      typeId: json['type_id'],
      clientId: json['client_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tarif': tarif,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'adresse': adresse,
      'code_postale': codePostale,
      'num_tel': numTel,
      'type_logement': typeLogement,
      'adresse_logement': adresseLogement,
      'date_construcion': dateConstruction,
      'surface': surface,
      'nb_pieces': nbPieces,
      'dependances': dependances,
      'veranda': veranda,
      'offre_id': offreId,
      'type_id': typeId,
      'client_id': clientId,
    };
  }
}
