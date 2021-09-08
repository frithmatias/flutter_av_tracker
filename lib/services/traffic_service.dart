import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/helpers/search_debouncer.dart';
import 'package:rutas_app/models/mapbox_places_response.dart';
import 'package:rutas_app/models/mapbox_response.dart';

class TrafficService {
  final _dio = Dio();
  final _placesUrl = 'https://api.mapbox.com/geocoding/v5';
  final _directionsUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey =
      'pk.eyJ1IjoiY29kZXI0MDQiLCJhIjoiY2sxMnBkMnl1MDA4cDNvcDFxanV4cThzZSJ9.qHR4JrSJ0aqpIG8VVRUTLw';

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  Future<MapboxResponse> getCoordsFromTo(LatLng from, LatLng to) async {
    final coordString =
        '${from.longitude},${from.latitude};${to.longitude},${to.latitude}';
    final url = '$_directionsUrl/mapbox/driving/$coordString';

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

  Future<List<Feature>> getPlaces(String pattern, LatLng position) async {
    
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


  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Feature>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Feature>> get suggestionStream => _suggestionStreamController.stream;

  // ANTES DE ENVIAR LA DATA AL API (getPlaces()) Y EL RESULTADO AL STREAM, PASO LA DATA POR EL DEBOUNCER
  void getSuggestionsByQuery(String searchBuffer, LatLng location) {

    print('En buffer: $searchBuffer');
    debouncer.value = '';
    debouncer.onValue = (value) async {
      print('Buscando: $value en $location');
      // UNA VEZ QUE RECIBO LA ORDEN DEL DEBOUNCER, ENVIO LA PETICIÓN AL API
      final results = await getPlaces(value, location);
      // ENVÍO LOS RESULTADOS AL STREAM
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchBuffer;
    });

    Future.delayed(const Duration(milliseconds: 305)).then((_) => timer.cancel());
  }


  void dispose() {
    _suggestionStreamController.close();
  }

}
