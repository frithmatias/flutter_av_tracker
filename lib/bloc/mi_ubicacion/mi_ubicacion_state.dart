part of 'mi_ubicacion_bloc.dart';

@immutable
// abstract class MiUbicacionState {}
class MiUbicacionState {

  // Todas las propiedades en cualquier STATE tiene que ser FINAL porque NO debe cambiar, cada vez 
  // que guardamos un nuevo estado para poder emitirlo tiene que suer una COPIA del estado anterior.
  final bool siguiendo; // si el usuario desea ser trackeado
  final bool existeUbicacion; // si tengo al menos una ubicacion va a ser TRUE.
  final LatLng? ubicacion; // coordenadas del usuario

  // sobre cualquier propiedad > Ctrl+. > Crear constructor 
  const MiUbicacionState({ // {} -> quiero que sean con nombre
    this.siguiendo = true, 
    this.existeUbicacion = false, 
    this.ubicacion
  }); // coordenadas del usuario


  // copyWith hace una copia de la ubicacion para un nuevo estado con los argumentos recibidos.
  MiUbicacionState copyWith({ 
    bool siguiendo = true,
    bool existeUbicacion = false,
    LatLng? ubicacion
  }) => MiUbicacionState(
    siguiendo: siguiendo,
    existeUbicacion: existeUbicacion, 
    ubicacion: ubicacion
  );


}

class UbicacionInitial extends MiUbicacionState {}
