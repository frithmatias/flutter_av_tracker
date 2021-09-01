part of 'mapa_bloc.dart';

@immutable

class MapaState {
  
  final bool mapaListo; 
  final bool? dibujarRecorrido;
  final Map<String, Polyline> polylines;

  const MapaState({
    this.mapaListo = false, 
    this.dibujarRecorrido = false,
    this.polylines = const {}
  });

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    Map<String, Polyline>? polylines
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo, 
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido, 
    polylines: polylines ?? this.polylines,
  );
  
  @override
  toString(){
    return 'mapaListo: $mapaListo dibujarRecorrido: $dibujarRecorrido num.polylines: ${polylines.length}';
  }
}



