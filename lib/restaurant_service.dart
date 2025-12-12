import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurant.dart';

class RestaurantService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'restaurantes',
  );

  Future<List<Restaurant>> getRestaurants() async {
    final snapshot = await _ref.get();

    return snapshot.docs.map((doc) {
      return Restaurant.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
