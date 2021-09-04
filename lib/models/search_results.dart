



import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResults {

  final bool cancelo;
  final bool? manual;
  final LatLng? ubicacion;
  final String? nombre;
  final String? descripcion;

  SearchResults(
    this.cancelo,
    [
      this.manual,
      this.ubicacion,
      this.nombre,
      this.descripcion
    ]
  );

}