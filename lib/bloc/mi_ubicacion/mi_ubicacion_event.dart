part of 'mi_ubicacion_bloc.dart';

@immutable
abstract class MiUbicacionEvent {}

// usualmente los eventos comienzan con ON
class OnUbicacionCambia extends MiUbicacionEvent{

  // recibo los argumentos. Como ya tengo importado google_maps_flutter.dart en el bloc, 
  // y los eventos y los estados son PARTE del bloc, no necesito importar nada mas.
  final LatLng ubicacion; 
  OnUbicacionCambia(this.ubicacion);
  

}