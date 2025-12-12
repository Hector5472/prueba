import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  final double? targetLat;
  final double? targetLng;

  const MapScreen({super.key, this.targetLat, this.targetLng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(27.9705707, -15.5810533),
    zoom: 10,
  );

  // Tus marcadores completos (no los toco)
  Set<Marker> _markers = {};

  Future<void> loadMarkers() async {
    final snap = await FirebaseFirestore.instance
        .collection('restaurantes')
        .get();

    final loaded = snap.docs.map((doc) {
      final data = doc.data();
      return Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(data['lat'], data['lng']),
        infoWindow: InfoWindow(title: data['nombre']),
      );
    }).toSet();

    setState(() {
      _markers = loaded;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa")),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        onMapCreated: (controller) {
          mapController = controller;

          if (widget.targetLat != null && widget.targetLng != null) {
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(widget.targetLat!, widget.targetLng!),
                15,
              ),
            );
          }
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
