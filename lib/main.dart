// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Restaurantes GC', home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pantallas = [HomeScreen(), const MapScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pantallas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),

          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> popularRestaurants = [
    {
      "name": "Mercadito Ibérico",
      "description": "Tapas y especialidades ibéricas.",
      "lat": 27.764484007529365,
      "lng": -15.681296589028689,
      "rating": 4.7,
    },
    {
      "name": "Restaurante Balcón Canario",
      "description": "Cocina canaria tradicional.",
      "lat": 27.79136876435827,
      "lng": -15.708060990933632,
      "rating": 4.6,
    },
    {
      "name": "Taberna El Refugio",
      "description": "Taberna acogedora con ambiente local.",
      "lat": 27.841749618520403,
      "lng": -15.451624230463299,
      "rating": 4.8,
    },
    {
      "name": "INSÓLITO Bistró Maspalomas",
      "description": "Italiano moderno con pizzas y pastas.",
      "lat": 27.769077982006962,
      "lng": -15.586443902162074,
      "rating": 4.5,
    },
    {
      "name": "Casa Brito",
      "description": "Parrilla famosa y carnes de calidad.",
      "lat": 28.105488872824637,
      "lng": -15.528079481127552,
      "rating": 4.9,
    },
  ];

  static const List<Map<String, dynamic>> nearbyRestaurants = [   // Son datos ficticios, no reales
  {
    "name": "Bar Casa Perdomo",
    "distance": 1.2,
    "type": "Comida canaria",
  },
  {
    "name": "Rincón de Chrisday",
    "distance": 2.0,
    "type": "Tapas",
  },
  {
    "name": "INSÓLITO Bistró Maspalomas",
    "distance": 2.3,
    "type": "Italiano",
  },
  {
    "name": "Mercadito Ibérico",
    "distance": 3.1,
    "type": "Ibérico",
  },
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food&Find', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Sección: Restaurantes Populares
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Restaurantes Populares",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            // Cards horizontal
            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularRestaurants.length,
                itemBuilder: (context, index) {
                  final rest = popularRestaurants[index];

                  return Container(
                    width: 220,
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 85,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          rest["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          rest["description"],
                          style: const TextStyle(fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        buildStars(rest["rating"]),

                        const Spacer(),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MapScreen(
                                    targetLat: rest["lat"],
                                    targetLng: rest["lng"],
                                  ),
                                ),
                              );
                            },
                            child: const Text("Ver en mapa"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            
// SECCIÓN: Restaurantes cerca de ti

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: const Text(
    "Cerca de Ti",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: nearbyRestaurants.length,
  itemBuilder: (context, index) {
    final rest = nearbyRestaurants[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 16, right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restaurant, color: Colors.green),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rest["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${rest["distance"]} km — ${rest["type"]}",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }

  Widget buildStars(double rating) {
    int full = rating.floor();
    bool half = (rating - full) >= 0.5;

    return Row(
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        } else if (i == full && half) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 18);
        }
      }),
    );
  }
}
