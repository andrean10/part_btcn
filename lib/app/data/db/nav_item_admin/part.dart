class Part {
  final String modelId;
  final String partId;
  final String description;
  final num price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int quantity;
  final List<String> images;

  Part({
    required this.modelId,
    required this.partId,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.quantity,
    required this.images,
  });
}
