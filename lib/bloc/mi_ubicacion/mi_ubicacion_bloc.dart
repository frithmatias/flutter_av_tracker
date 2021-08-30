import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  
  late StreamSubscription<Position> _positionSubscription;
  
  MiUbicacionBloc() : super(UbicacionInitial());

  void iniciarSeguimiento(){
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high, 
      distanceFilter: 10, //cuando se mueve 10 metros emite una nueva posicion
    ).listen(( Position position ) { 
      // tengo que convertir el tipo Position al tipo LatLng (porque así lo recibe el evento)
      final ubicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambia(ubicacion)); 
      // envío la posición al evento OnUbicacionCambia() que va a disparar el metodo mapEventToState
      print(position);
    });
  }

  void cancelarSeguimiento(){
    _positionSubscription.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState( MiUbicacionEvent event ) async* {
  
    if(event is OnUbicacionCambia){
      yield state.copyWith(  
        existeUbicacion: true, 
        ubicacion: event.ubicacion
      );
    }
    
  }


}
