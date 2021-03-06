import 'dart:convert';

import 'mapbox_place.dart';

MapboxPlacesResponse mapboxPlacesResponseFromJson(String str) => MapboxPlacesResponse.fromJson(json.decode(str));

String mapboxPlacesResponseToJson(MapboxPlacesResponse data) => json.encode(data.toJson());

class MapboxPlacesResponse {
    MapboxPlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    String type;
    List<String> query;
    List<Place> features;
    String attribution;

    factory MapboxPlacesResponse.fromJson(Map<String, dynamic> json) => MapboxPlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
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
