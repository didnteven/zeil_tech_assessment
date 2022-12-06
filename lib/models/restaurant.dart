///data models for Businesses (aka restaurants)
class Business {
  Business({
    required this.id,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClosed,
    required this.url,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.coordinates,
    required this.transactions,
    required this.price,
    required this.location,
    required this.phone,
    required this.displayPhone,
    required this.distance,
  });
  late final String id;
  late final String alias;
  late final String name;
  late final String imageUrl;
  late final bool isClosed;
  late final String url;
  late final int reviewCount;
  late final List<Categories> categories;
  late final double rating;
  late final Coordinates coordinates;
  late final List<dynamic> transactions;
  late final String? price;
  late final Location location;
  late final String phone;
  late final String displayPhone;
  late final double distance;

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alias = json['alias'];
    name = json['name'];
    imageUrl = json['image_url'];
    isClosed = json['is_closed'];
    url = json['url'];
    reviewCount = json['review_count'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    rating = json['rating'];
    coordinates = Coordinates.fromJson(json['coordinates']);
    transactions = List.castFrom<dynamic, dynamic>(json['transactions']);
    price = json['price'];
    location = Location.fromJson(json['location']);
    phone = json['phone'];
    displayPhone = json['display_phone'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['alias'] = alias;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['is_closed'] = isClosed;
    data['url'] = url;
    data['review_count'] = reviewCount;
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['rating'] = rating;
    data['coordinates'] = coordinates.toJson();
    data['transactions'] = transactions;
    data['price'] = price;
    data['location'] = location.toJson();
    data['phone'] = phone;
    data['display_phone'] = displayPhone;
    data['distance'] = distance;
    return data;
  }
}

class Categories {
  Categories({
    required this.alias,
    required this.title,
  });
  late final String alias;
  late final String title;

  Categories.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['alias'] = alias;
    data['title'] = title;
    return data;
  }
}

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });
  late final double latitude;
  late final double longitude;

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Location {
  Location({
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.state,
    required this.displayAddress,
  });
  late final String address1;
  late final String? address2;
  late final String? address3;
  late final String city;
  late final String zipCode;
  late final String country;
  late final String? state;
  late final List<String>? displayAddress;

  Location.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    state = json['state'];
    displayAddress = List.castFrom<dynamic, String>(json['display_address']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['address3'] = address3;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['state'] = state;
    data['display_address'] = displayAddress;
    return data;
  }
}

class Region {
  Region({
    required this.center,
  });
  late final CenterLocation center;

  Region.fromJson(Map<String, dynamic> json) {
    center = CenterLocation.fromJson(json['center']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['center'] = center.toJson();
    return data;
  }
}

class CenterLocation {
  CenterLocation({
    required this.longitude,
    required this.latitude,
  });
  late final double longitude;
  late final double latitude;

  CenterLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
