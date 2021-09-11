part of 'mapa_bloc.dart';

@immutable

class MapaState {
  
  final bool mapaListo; 
  final bool dibujarRecorrido;
  final bool seguir;
  final LatLng ubicacionCentral;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;


  const MapaState({
    this.mapaListo = false, 
    this.dibujarRecorrido = false,
    this.seguir = false,
    this.ubicacionCentral = const LatLng(0,0),
    this.polylines = const {},
    this.markers = const {}
  });

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? seguir,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,

  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo, 
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido, 
    seguir: seguir ?? this.seguir,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers
  );
  
  @override
  toString(){
    return 'mapaListo: $mapaListo dibujarRecorrido: $dibujarRecorrido seguir: $seguir num.polylines: ${polylines.length}';
  }
}



