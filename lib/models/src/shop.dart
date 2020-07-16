class Shop {
  Shop({
    this.id,
    this.fields,
  });

  String id;
  Fields fields;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["ID"],
        fields: Fields.fromJson(json["Fields"]),
      );
}

class Fields {
  Fields({
    this.name,
    this.imageUrl,
    this.locationDisplayAddress001,
    this.locationDisplayAddress002,
    this.displayPhone,
    this.coordinatesLatitude,
    this.coordinatesLongitude,
    this.flavors,
    this.locationDisplayAddress003,
  });

  String name;
  String imageUrl;
  String locationDisplayAddress001;
  String locationDisplayAddress002;
  String displayPhone;
  String coordinatesLatitude;
  String coordinatesLongitude;
  List<String> flavors;
  String locationDisplayAddress003;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        imageUrl: json["image_url"],
        locationDisplayAddress001: json["location_display_address_001"],
        locationDisplayAddress002: json["location_display_address_002"],
        displayPhone: json["display_phone"],
        coordinatesLatitude: json["coordinates_latitude"],
        coordinatesLongitude: json["coordinates_longitude"],
        flavors: List<String>.from(json["flavors"].map((x) => x)),
        locationDisplayAddress003: json["location_display_address_003"] == null
            ? null
            : json["location_display_address_003"],
      );
}
