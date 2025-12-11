import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("rest1"),
      position: LatLng(27.764484007529365, -15.681296589028689),
      infoWindow: InfoWindow(title: "Mercadito Iberico"),
    ),
    Marker(
      markerId: MarkerId("rest2"),
      position: LatLng(27.79136876435827, -15.708060990933632),
      infoWindow: InfoWindow(title: "Restaurante Balcon Canario"),
    ),
    Marker(
      markerId: MarkerId("rest3"),
      position: LatLng(27.841749618520403, -15.451624230463299),
      infoWindow: InfoWindow(title: "Taberna el refugio"),
    ),
    Marker(
      markerId: MarkerId("rest4"),
      position: LatLng(27.877275794264996, -15.415974190744286),
      infoWindow: InfoWindow(title: "Rincón De Chrisday"),
    ),
    Marker(
      markerId: MarkerId("rest5"),
      position: LatLng(27.769077982006962, -15.586443902162074),
      infoWindow: InfoWindow(title: "INSÓLITO BISTRÓ MASPALOMAS Italian Restaurant & Pizza"),
    ),
    Marker(
      markerId: MarkerId("rest6"),
      position: LatLng(27.8416316512396, -15.47538063643671),
      infoWindow: InfoWindow(title: "Bar Casa Perdomo"),
    ),
    Marker(
      markerId: MarkerId("rest7"),
      position: LatLng(27.769043245045744, -15.581404249991037),
      infoWindow: InfoWindow(title: "Restaurante Tertulia y Enyesque"),
    ),
    Marker(
      markerId: MarkerId("rest8"),
      position: LatLng(27.77300021810428, -15.582787748592073),
      infoWindow: InfoWindow(title: "Restaurante Grill La Casa Vieja"),
    ),
    Marker(
      markerId: MarkerId("rest9"),
      position: LatLng(27.76334469414967, -15.565858051583227),
      infoWindow: InfoWindow(title: "Mulligan´s Irish Pub Gran Canaria"),
    ),
    Marker(
      markerId: MarkerId("rest10"),
      position: LatLng(27.996410811629048, -15.417911004161127),
      infoWindow: InfoWindow(title: "Bar restaurante Casa Mario"),
    ),
    Marker(
      markerId: MarkerId("rest11"),
      position: LatLng(27.99167241419049, -15.614703064401587),
      infoWindow: InfoWindow(title: "Bar - Restaurante Arraigo"),
    ),
    Marker(
      markerId: MarkerId("rest12"),
      position: LatLng(27.999450611358846, -15.417705437390474),
      infoWindow: InfoWindow(title: "Restaurante asador Ca'tita"),
    ),
    Marker(
      markerId: MarkerId("rest13"),
      position: LatLng(28.103268805267465, -15.414987911591036),
      infoWindow: InfoWindow(title: "Chao Chao Noodles & Gyoza"),
    ),
    Marker(
      markerId: MarkerId("rest14"),
      position: LatLng(28.102089930981915, -15.41428057978777),
      infoWindow: InfoWindow(title: "Restaurante Triciclo"),
    ),
    Marker(
      markerId: MarkerId("rest15"),
      position: LatLng(28.105488872824637, -15.528079481127552),
      infoWindow: InfoWindow(title: "Casa Brito"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa")),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers, // mantengo todos los marcadores
        onMapCreated: (controller) {
          mapController = controller;

          // si se pasaron coordenadas desde "Ver en mapa"
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
