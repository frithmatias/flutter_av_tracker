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


class OnCrearRuta extends MapaEvent{
  final List<LatLng> rutaCoords;
  final double distancia;
  final double duracion;
  final Place place;
  OnCrearRuta(this.rutaCoords, this.distancia, this.duracion, this.place);
}