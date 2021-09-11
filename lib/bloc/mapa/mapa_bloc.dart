import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/models/mapbox_place.dart';
import 'package:rutas_app/themes/uber_map.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  late GoogleMapController mapController;
  Polyline _mirecorrido = Polyline(
      polylineId: const PolylineId('mi_recorrido'),
      width: 4,
      color: Colors.yellow.shade800);
  Polyline _miruta = const Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.black87);

  MapaBloc() : super(const MapaState());

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      mapController = controller;
      mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    mapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapaListo) {
      yield state.copyWith(mapaListo: true);
    } else if (event is OnCambiaUbicacion) {
      yield* _onCambiaUbicacion(event);
    } else if (event is OnSeguir) {
      yield state.copyWith(seguir: !state.seguir);
    } else if (event is OnMarcarRecorrido) {
      yield state.copyWith(dibujarRecorrido: !state.dibujarRecorrido);
    } else if (event is OnMapaMovio) {
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if (event is OnCrearRuta) {
      yield* _onCrearRuta(event);
    }
  }

  Stream<MapaState> _onCambiaUbicacion(OnCambiaUbicacion event) async* {
    List<LatLng> points = [..._mirecorrido.points, event.ubicacion];
    _mirecorrido = _mirecorrido.copyWith(pointsParam: points);
    Map<String, Polyline> currentPolylines = {};
    currentPolylines.addAll(state.polylines);
    currentPolylines['mi_recorrido'] = _mirecorrido;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onCrearRuta(OnCrearRuta event) async* {


    // 1. LIB\HELPERS\CUSTOM_MARKERS.DART
    // var iconoInicio = await getIconoAssets();
    // var iconoDestino = await getIconoNetwork();
    
    // 2. LIB\MARKERS PNG Generated Markers
    var iconoInicio = await getMarkerInicio(event.duracion.toInt());
    var iconoDestino = await getMarkerDestino(event.place.text, event.distancia);
    
    final markerInicio = Marker(
        icon: iconoInicio,
        anchor: const Offset(0.05, .9),
        markerId: const MarkerId('inicio'), 
        position: event.rutaCoords[0],
        // infoWindow: const InfoWindow(title: 'Inicio', snippet: 'Punto de partida')
    );

    final markerFin = Marker(
        icon: iconoDestino,
        anchor: const Offset(0.05, .9),
        markerId: const MarkerId('fin'),
        position: event.rutaCoords[event.rutaCoords.length - 1],
        // infoWindow: InfoWindow(title: event.place.text, snippet: event.place.properties.address)
    );

    final newMarkers = {...state.markers};
    newMarkers['inicio'] = markerInicio;
    newMarkers['fin'] = markerFin;

    _miruta = _miruta.copyWith(pointsParam: event.rutaCoords);
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = _miruta;

    yield state.copyWith(polylines: currentPolylines, markers: newMarkers);
  }
}
