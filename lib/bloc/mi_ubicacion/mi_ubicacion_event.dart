part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

class OnUbicacionCambia extends MiUbicacionEvent{

  final LatLng ubicacion; 
  
  OnUbicacionCambia(this.ubicacion);
  
}