class CarInsurancePlan {
  final int id;
  final String name;
  final String price;
  final String? liabilityToOthers;
  final String? defense;
  final String? assistance;
  final String? coverage;
  final String? storm;
  final String? terrorism;
  final String? breakage;
  final String? fire;
  final String? theft;
  final String? compensation;
  final String? accidentDamage;
  final String? extendedBreakage;
  final String? contents;
  final String? keyAssistance;
  final String? roadsideAssistance0km;
  final String? vehicleAssistance;
  final String? extension;
  final String? redemption;
  final String? personalGuarantee;

  CarInsurancePlan({
    required this.id,
    required this.name,
    required this.price,
    required this.liabilityToOthers,
    required this.defense,
    required this.assistance,
    required this.coverage,
    required this.storm,
    required this.terrorism,
    required this.breakage,
    required this.fire,
    required this.theft,
    required this.compensation,
    required this.accidentDamage,
    required this.extendedBreakage,
    required this.contents,
    required this.keyAssistance,
    required this.roadsideAssistance0km,
    required this.vehicleAssistance,
    required this.extension,
    required this.redemption,
    required this.personalGuarantee,
  });
  factory CarInsurancePlan.fromJson(Map<String, dynamic> json) {
    return CarInsurancePlan(
      id: json['id'],
      name: json['nom'] ?? '',
      price: json['tarif'] ?? '',
      liabilityToOthers: json['dommage_autrui'] ?? '',
      defense: json['defense'] ?? '',
      assistance: json['assistance'] ?? '',
      coverage: json['garantie'] ?? '',
      storm: json['tempete'] ?? '',
      terrorism: json['attentat'] ?? '',
      breakage: json['bris'] ?? '',
      fire: json['incendie'] ?? '',
      theft: json['vol'] ?? '',
      compensation: json['indemnisation'] ?? '',
      accidentDamage: json['dommage_accidents'] ?? '',
      extendedBreakage: json['bris_etendu'] ?? '',
      contents: json['contenu'] ?? '',
      keyAssistance: json['assistance_cle'] ?? '',
      roadsideAssistance0km: json['assistance_0km'] ?? '',
      vehicleAssistance: json['assistance_vehicule'] ?? '',
      extension: json['extention'] ?? '',
      redemption: json['rachat'] ?? '',
      personalGuarantee: json['garantie_per'] ?? '',
    );
  }
}
