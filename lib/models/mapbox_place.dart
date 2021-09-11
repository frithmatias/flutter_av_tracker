class Place {
    Place({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.text,
        required this.placeName,
        required this.center,
        required this.geometry,
        this.context,
        this.bbox,
    });

    String id;
    String type;
    List<String> placeType;
    int relevance;
    Properties properties;
    String text;
    String placeName;
    List<double> center;
    Geometry geometry;
    List<Context>? context;
    List<double>? bbox;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"],
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: json["context"] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": context == null ? null : List<dynamic>.from(context!.map((x) => x.toJson())),
        "bbox": bbox == null ? null : List<dynamic>.from(bbox!.map((x) => x)),
    };
}

class Context {
    Context({
        this.id,
        this.wikidata,
        this.text,
        this.shortCode,
    });

    String? id;
    String? wikidata;
    String? text;
    String? shortCode;

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"],
        text: json["text"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata,
        "text": text,
        "short_code": shortCode,
    };
}

class Geometry {
    Geometry({
        required this.coordinates,
        required this.type,
    });

    List<double> coordinates;
    String type;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    Properties({
        this.foursquare,
        this.landmark,
        this.address,
        this.category,
        this.wikidata,
        this.shortCode,
    });

    String? foursquare;
    bool? landmark;
    String? address;
    String? category;
    String? wikidata;
    String? shortCode;

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "wikidata": wikidata,
        "short_code": shortCode,
    };
}
