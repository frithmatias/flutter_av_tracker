part of 'mi_ubicacion_bloc.dart';

@immutable

class MiUbicacionState {

  final bool siguiendo; 
  final bool existeUbicacion; 
  final LatLng ubicacion; 
  
  const MiUbicacionState({ 
    this.siguiendo = true, 
    this.existeUbicacion = false, 
    this.ubicacion = const LatLng(0, 0),
  }); 
  
  MiUbicacionState copyWith({ 
    bool siguiendo = true,
    bool existeUbicacion = false,
    LatLng ubicacion = const LatLng(0, 0),
  }) => MiUbicacionState(
    siguiendo: siguiendo,
    existeUbicacion: existeUbicacion, 
    ubicacion: ubicacion
  );


}

class UbicacionInitial extends MiUbicacionState {}
