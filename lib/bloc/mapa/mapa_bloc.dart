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
    if(event is OnMapaListo){
      yield state.copyWith( mapaListo: true);
    } else if (event is OnCambiaUbicacion) {

      List<LatLng> points = [..._miruta.points, event.ubicacion];
      _miruta = _miruta.copyWith(pointsParam: points);
      Map<String, Polyline> currentPolylines = {'mi_ruta': _miruta};

      for( Polyline polyline in currentPolylines.values){
        print('${polyline.polylineId.value} -> ${polyline.points.length}');
      }
      yield state.copyWith(polylines: currentPolylines);
    }
  }
}
