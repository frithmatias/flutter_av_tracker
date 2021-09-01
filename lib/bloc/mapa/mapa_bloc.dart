import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/themes/uber_map.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  
  late GoogleMapController mapController;

  Polyline _miruta = Polyline(
    polylineId: const PolylineId('mi_ruta'),
    width: 4,
    color: Colors.yellow.shade800,
  );

  MapaBloc() : super(const MapaState());

  void initMapa( GoogleMapController controller){
    if(!state.mapaListo){
      mapController = controller;
      mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapaListo());
    }
  }


  void moverCamara( LatLng destino ) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    mapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
         if ( event is OnMapaListo ) { yield state.copyWith( mapaListo: true); } 
    else if ( event is OnCambiaUbicacion ) { yield* _onCambiaUbicacion(event); } //(*)
    else if ( event is OnSeguir ) { yield state.copyWith( seguir: !state.seguir); } 
    else if ( event is OnMarcarRecorrido ) { yield state.copyWith(dibujarRecorrido: !state.dibujarRecorrido); }
    else if ( event is OnMapaMovio ) { 
      print('se movio el mapa: ${event.centroMapa}');
      yield state.copyWith(ubicacionCentral: event.centroMapa); 
      }

  }

  // (*) con * le estoy diciendo que NO regrese TÓDO el Stream, sino SÓLO la emisión de ese Stream
  // (**) el * en async* lo convierte en una función generadora
  
  Stream<MapaState> _onCambiaUbicacion(OnCambiaUbicacion event) async* { //(**)
    List<LatLng> points = [..._miruta.points, event.ubicacion];
    _miruta = _miruta.copyWith(pointsParam: points);
    Map<String, Polyline> currentPolylines = {'mi_ruta': _miruta};
    yield state.copyWith(polylines: currentPolylines);
  }
}
