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



  Polyline _mirecorrido = Polyline(polylineId: const PolylineId('mi_recorrido'), width: 4, color: Colors.yellow.shade800 );
  Polyline _miruta = const Polyline(polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.black87 );


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
    else if ( event is OnMapaMovio ) { yield state.copyWith(ubicacionCentral: event.centroMapa); }
    else if ( event is OnCrearRuta ) { yield* _onCrearRuta(event); }
  }

  // (*) con * le estoy diciendo que NO regrese TÓDO el Stream, sino SÓLO la emisión de ese Stream
  // (**) el * en async* lo convierte en una función generadora
  
  Stream<MapaState> _onCambiaUbicacion(OnCambiaUbicacion event) async* { //(**)
    List<LatLng> points = [..._mirecorrido.points, event.ubicacion];
    _mirecorrido = _mirecorrido.copyWith(pointsParam: points);
    Map<String, Polyline> currentPolylines = {'mi_recorrido': _mirecorrido};
    yield state.copyWith(polylines: currentPolylines);
  }


  Stream<MapaState> _onCrearRuta(OnCrearRuta event) async* {

    // tengo que crear una nueva polyline con mis waypoints 
    _miruta = _miruta.copyWith( pointsParam: event.rutaCoords );

    // en mi estado tengo TODOS mis polylines (es un mapa de polylines)
    final currentPolylines = state.polylines;

    // agrego o piso mi polyline 'mi_ruta'
    currentPolylines['mi_ruta'] = _miruta; 

    // devuelvo una nueva copia de mis polylines, esta vez con el nuevo polyline 'mi_ruta'
    yield state.copyWith(polylines: currentPolylines);

  }
}
