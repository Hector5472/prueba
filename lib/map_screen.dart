import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(28.123, -15.436), // Gran Canaria (aprox)
    zoom: 12,
  );

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("rest1"),
      position: LatLng(28.1248, -15.4300),
      infoWindow: InfoWindow(title: "Cafetería Las Palmas"),
    ),
    Marker(
      markerId: MarkerId("rest2"),
      position: LatLng(28.1000, -15.4130),
      infoWindow: InfoWindow(title: "Restaurante Puerto"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        onMapCreated: (controller) => mapController = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
