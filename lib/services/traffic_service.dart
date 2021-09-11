import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/helpers/search_debouncer.dart';
import 'package:rutas_app/models/mapbox_info_response.dart';
import 'package:rutas_app/models/mapbox_place.dart';
import 'package:rutas_app/models/mapbox_places_response.dart';
import 'package:rutas_app/models/mapbox_response.dart';
import 'package:polyline_do/polyline_do.dart' as poly;
import 'package:flutter_bloc/flutter_bloc.dart';
 
class TrafficService {
  final _dio = Dio();
  final _placesUrl = 'https://api.mapbox.com/geocoding/v5';
  final _routesUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoiY29kZXI0MDQiLCJhIjoiY2sxMnBkMnl1MDA4cDNvcDFxanV4cThzZSJ9.qHR4JrSJ0aqpIG8VVRUTLw';
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Place>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Place>> get suggestionStream => _suggestionStreamController.stream;

  factory TrafficService() {
    return _instance;
  }

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();


  void getRouteTo(BuildContext context, LatLng? destination) async {

    calculandoAlerta(context);

    final from = context.read<MiUbicacionBloc>().state.ubicacion;
    final to = destination ?? context.read<MapaBloc>().state.ubicacionCentral;

    final mapboxRoute = await getRoute(from, to);
    final mapboxInfo = await getInfo(to);

    final geometry = mapboxRoute.routes[0].geometry;
    final duration = mapboxRoute.routes[0].duration;
    final distance = mapboxRoute.routes[0].distance;
    final place = mapboxInfo[0];

    final coords = poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    final List<LatLng> points = coords.map((coord) => LatLng(coord[0], coord[1])).toList();

    context.read<MapaBloc>().add(OnCrearRuta(points, distance, duration, place));
    context.read<MapaBloc>().moverCamara(context.read<MiUbicacionBloc>().state.ubicacion);
    context.read<BusquedaBloc>().add(OnDesactivarMarcadorManual());

    Navigator.of(context).pop();

  }

  Future<MapboxResponse> getRoute(LatLng from, LatLng to) async {

    final coordString = '${from.longitude},${from.latitude};${to.longitude},${to.latitude}';
    final url = '$_routesUrl/mapbox/driving/$coordString';

    final resp = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'true',
      'access_token': _apiKey,
      'language': 'es',
    });
    
    final data = MapboxResponse.fromJson(resp.data);
    return data;
  
  }

  Future<List<Place>> getInfo(LatLng position) async {
    
    final url = '$_placesUrl/mapbox.places/${position.longitude},${position.latitude}.json';
    _dio.options.headers['Content-Type'] = 'application/json';

    final resp = await _dio.get(url, queryParameters: {
      'access_token': _apiKey,
      'language': 'es',
      'country': 'ar'
    });
    
    final data = mapboxInfoResponseFromJson(resp.data);
    return data.features;
    
  }

  void getPlacesFrom(String searchBuffer, LatLng location) {

    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await getPlaces(value, location);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchBuffer;
    });

    Future.delayed(const Duration(milliseconds: 305)).then((_) => timer.cancel());
  }

  Future<List<Place>> getPlaces(String pattern, LatLng position) async {
    
    if(pattern.isEmpty) return [];

    final url = '$_placesUrl/mapbox.places/$pattern.json';
    _dio.options.headers['Content-Type'] = 'application/json';

    final resp = await _dio.get(url, queryParameters: {
      'cachebuster': '1631027915504',
      'autocomplete': 'true',
      'access_token': _apiKey,
      'language': 'es',
      'country': 'ar',
      'proximity': '${position.longitude},${position.latitude}'
    });

    final data = mapboxPlacesResponseFromJson(resp.data);
    return data.features;
    
  }

  void dispose() {
    _suggestionStreamController.close();
  }

}
