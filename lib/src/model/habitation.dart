class Habitation {
  final int id;
  final String nom;
  final int tarif;
  final bool responsabilite;
  final bool defense;
  final bool incendie;
  final bool degats;
  final bool evenementClimatique;
  final bool catastrophes;
  final bool attentas;
  final bool assistance;
  final bool bris;
  final bool volVandalisme;
  final bool volCasse;
  final String? indemnisation;
  final String? indemnisationObjets;
  final DateTime createdAt;
  final DateTime updatedAt;

  Habitation({
    required this.id,
    required this.nom,
    required this.tarif,
    required this.responsabilite,
    required this.defense,
    required this.incendie,
    required this.degats,
    required this.evenementClimatique,
    required this.catastrophes,
    required this.attentas,
    required this.assistance,
    required this.bris,
    required this.volVandalisme,
    required this.volCasse,
    required this.indemnisation,
    required this.indemnisationObjets,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Habitation.fromJson(Map<String, dynamic> json) {
    return Habitation(
      id: json['id'],
      nom: json['nom'],
      tarif: int.parse(json['tarif']),
      responsabilite: json['responsabilite'],
      defense: json['defense'],
      incendie: json['incendie'],
      degats: json['degats'],
      evenementClimatique: json['evenement_climatique'],
      catastrophes: json['catastrophes'],
      attentas: json['attentas'],
      assistance: json['assistance'],
      bris: json['bris'],
      volVandalisme: json['vol_vandalisme'],
      volCasse: json['vol_casse'],
      indemnisation: json['indemnisation'],
      indemnisationObjets: json['indemnisation_objets'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
