class Restaurant {
  final String id;
  final String name;
  final String description;
  final String category;
  final double lat;
  final double lng;
  final double rating;
  final String imageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.imageUrl,
  });

  factory Restaurant.fromMap(String id, Map<String, dynamic> data) {
    return Restaurant(
      id: id,
      name: data['nombre'],
      description: data['descipcion'],
      category: data['categoria'],
      lat: data['lat'],
      lng: data['lng'],
      rating: (data['rating'] ?? 0).toDouble(),
      imageUrl: data['imagenURL'],
    );
  }
}
