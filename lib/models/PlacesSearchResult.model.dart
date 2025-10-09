class PlacesSearchResult {
  String icon;
  String id;
  String name;
  String vicinity;
  double? rating;
  Geometry geometry;

  PlacesSearchResult({
    required this.icon,
    required this.id,
    required this.name,
    required this.vicinity,
    this.rating,
    required this.geometry,
  });

  // Factory method to create a PlacesSearchResult instance from JSON data
  factory PlacesSearchResult.fromJson(Map<String, dynamic> json) {
    return PlacesSearchResult(
      icon: json['icon'],
      id: json['id'],
      name: json['name'],
      vicinity: json['vicinity'],
      rating: json['rating']?.toDouble(),
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Geometry {
  Location location;

  Geometry({required this.location});

  // Factory method to create a Geometry instance from JSON data
  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  double lat;
  double lng;

  Location({required this.lat, required this.lng});

  // Factory method to create a Location instance from JSON data
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
