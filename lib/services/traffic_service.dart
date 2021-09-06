

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/models/mapbox_response.dart';

class TrafficService {


  final _dio = Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoiY29kZXI0MDQiLCJhIjoiY2sxMnBkMnl1MDA4cDNvcDFxanV4cThzZSJ9.qHR4JrSJ0aqpIG8VVRUTLw';


  /// Vamos a hacer un Singleton con un factory constructor y un constructor privado para que cada vez 
  /// que se quiera crear una instancia de mi TrafficService uitilice la misma instancia anterior.

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  /// constructor factory que se llama con new y se obtiene la misma instancia
  factory TrafficService(){
    return _instance;
  }

  Future<MapboxResponse> getCoordsFromTo(LatLng from, LatLng to) async {

    final coordString = '${from.longitude},${from.latitude};${to.longitude},${to.latitude}';
    final url = '$_baseUrl/mapbox/driving/$coordString';

    final resp = await _dio.get(url,queryParameters:{
      'alternatives':'true',
      'geometries':'polyline6',
      'steps':'true',
      'access_token':_apiKey,
      'language':'es',
    });


    final data = MapboxResponse.fromJson(resp.data);

    return data;
    // data:Map (4 items)
    //   0:"routes" -> List (2 items)
    //   key:"routes"
    //   value:List (2 items)
    //     [0]:Map (6 items)
    //       0:"weight_name" -> "auto"
    //       1:"weight" -> 346.779
    //       2:"duration" -> 259.626
    //       3:"distance" -> 1263.875
    //       4:"legs" -> List (1 item)
    //       5:"geometry" -> "nmx}`AxlbrnBeJhIbs@ppAv}Ic}Hvq@~pAus@~n@_MgU"
  }

}