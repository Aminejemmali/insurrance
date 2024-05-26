class Lawyer {
  final String name;
  final String? image;
  final List<String> categories;
  final String description;

  Lawyer({
    required this.name,
    this.image,
    required this.categories,
    required this.description,
  });
}