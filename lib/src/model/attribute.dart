class Attribute {
  final String title;
  final String description;

  Attribute({
    required this.title,
    required this.description,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      title: json['titre'] as String,
      description: json['description'] as String,
    );
  }
}
