// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'restaurant_service.dart';
import 'restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Food&Find', home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pantallas = [HomeScreen(), const MapScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantallas[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),

          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        ],
        onTap: (index) {
          setState(() => currentIndex = index); // Cambia la pantalla actual a la seleccionada
        },
      ),
    );
  }
}

//------------------- Pantalla de inicio ------------------//
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RestaurantService service = RestaurantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food&Find', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: service.getRestaurants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Lista de restaurantes de Firebase
          final restaurantes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: restaurantes.length,
            itemBuilder: (context, index) {
              final rest = restaurantes[index];

              // Tarjetas de restaurantes
              return Container(
                margin: const EdgeInsets.only(bottom: 18),
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
                child: Row(
                  children: [
                    // Imagen
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: rest.imagenURL.isEmpty
                            ? const Icon(
                                Icons.restaurant,
                                color: Colors.green,
                                size: 32,
                              )
                            : Image.network(
                                rest.imagenURL,   // En firebase se detalla la URL completa /assets/images/...
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.restaurant,
                                    color: Colors.green,
                                    size: 32,
                                  );
                                },
                              ),
                      ),
                    ),

                    const SizedBox(width: 12),  // Solo es un espacio entre imagen y texto

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rest.nombre,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rest.categoria,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          buildStars(rest.rating),
                        ],
                      ),
                    ),


                    // Redireccion a mapa con los parametros de latitud y longitud del restaurante
                    IconButton(
                      icon: const Icon(Icons.map, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapScreen(
                              targetLat: rest.lat,
                              targetLng: rest.lng,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
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
