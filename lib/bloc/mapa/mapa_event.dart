part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}

class OnCambiaUbicacion extends MapaEvent{
  final LatLng ubicacion;
  OnCambiaUbicacion(this.ubicacion);
}