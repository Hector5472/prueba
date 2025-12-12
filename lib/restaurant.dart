class Restaurant {
  final String id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final double lat;
  final double lng;
  final double rating;
  final String imagenURL;

  Restaurant({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.imagenURL,
  });

  factory Restaurant.fromMap(String id, Map<String, dynamic> data) {
    return Restaurant(
      id: id,
      nombre: data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      categoria: data['categoria'] ?? '',
      lat: (data['lat'] ?? 0).toDouble(),
      lng: (data['lng'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      imagenURL: data['imagenURL'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'lat': lat,
      'lng': lng,
      'rating': rating,
      'imagenURL': imagenURL,
    };
  }
}
