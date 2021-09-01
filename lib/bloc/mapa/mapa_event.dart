part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}

class OnCambiaUbicacion extends MapaEvent{
  final LatLng ubicacion;
  OnCambiaUbicacion(this.ubicacion);
}

class OnMarcarRecorrido extends MapaEvent{}

class OnSeguir extends MapaEvent{}

class OnMapaMovio extends MapaEvent{
  final LatLng centroMapa;
  OnMapaMovio(this.centroMapa);
}