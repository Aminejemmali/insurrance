
import 'package:insurrance/src/model/attribute.dart';

class Offer {
  final int id;
  final String name;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Attribute> attributes;

  Offer({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      name: json['nom'] as String,
      price: json['tarif'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      attributes: (json['attribut'] as List)
          .map((attribute) => Attribute.fromJson(attribute as Map<String, dynamic>))
          .toList(),
    );
  }
}
