part of 'mapa_bloc.dart';

@immutable

class MapaState {
  
  final bool mapaListo; 
  final bool dibujarRecorrido;
  final Map<String, Polyline> polylines;

  const MapaState({
    this.mapaListo = false, 
    this.dibujarRecorrido = true,
    this.polylines = const {}
  });

  MapaState copyWith({
    bool mapaListo = false,
    bool dibujarRecorrido = false,
    Map<String, Polyline> polylines = const {}
  }) => MapaState(
    mapaListo: mapaListo, 
    dibujarRecorrido: dibujarRecorrido,
    polylines: polylines,
  );

  @override
  toString(){
    return '$mapaListo $dibujarRecorrido $polylines';
  }
}



