import 'dart:convert';
import 'mapbox_place.dart';

MapboxInfoResponse mapboxInfoResponseFromJson(String str) => MapboxInfoResponse.fromJson(json.decode(str));

String mapboxInfoResponseToJson(MapboxInfoResponse data) => json.encode(data.toJson());

class MapboxInfoResponse {
    MapboxInfoResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    String type;
    List<double> query;
    List<Place> features;
    String attribution;

    factory MapboxInfoResponse.fromJson(Map<String, dynamic> json) => MapboxInfoResponse(
        type: json["type"],
        query: List<double>.from(json["query"].map((x) => x.toDouble())),
        features: List<Place>.from(json["features"].map((x) => Place.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

