///Objects for Restaurant detailed information
class RestaurantDetails {
  RestaurantDetails({
    required this.id,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClaimed,
    required this.isClosed,
    required this.url,
    required this.phone,
    required this.displayPhone,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.location,
    required this.coordinates,
    required this.photos,
    required this.price,
    required this.hours,
    required this.transactions,
  });
  late final String id;
  late final String alias;
  late final String name;
  late final String imageUrl;
  late final bool isClaimed;
  late final bool isClosed;
  late final String url;
  late final String phone;
  late final String displayPhone;
  late final int reviewCount;
  late final List<Categories> categories;
  late final double rating;
  late final Location location;
  late final Coordinates coordinates;
  late final List<String> photos;
  late final String? price;
  late final List<Hours>? hours;
  late final List<dynamic> transactions;

  RestaurantDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alias = json['alias'];
    name = json['name'];
    imageUrl = json['image_url'];
    isClaimed = json['is_claimed'];
    isClosed = json['is_closed'];
    url = json['url'];
    phone = json['phone'];
    displayPhone = json['display_phone'];
    reviewCount = json['review_count'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    rating = json['rating'];
    location = Location.fromJson(json['location']);
    coordinates = Coordinates.fromJson(json['coordinates']);
    photos = List.castFrom<dynamic, String>(json['photos']);
    price = json['price'];
    hours = json['hours'] != null
        ? List.from(json['hours']).map((e) => Hours.fromJson(e)).toList()
        : null;
    transactions = List.castFrom<dynamic, dynamic>(json['transactions']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['alias'] = alias;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['is_claimed'] = isClaimed;
    data['is_closed'] = isClosed;
    data['url'] = url;
    data['phone'] = phone;
    data['display_phone'] = displayPhone;
    data['review_count'] = reviewCount;
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['rating'] = rating;
    data['location'] = location.toJson();
    data['coordinates'] = coordinates.toJson();
    data['photos'] = photos;
    data['price'] = price;
    data['hours'] = hours?.map((e) => e.toJson()).toList();
    data['transactions'] = transactions;
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
    required this.crossStreets,
  });
  late final String address1;
  late final String? address2;
  late final String? address3;
  late final String city;
  late final String zipCode;
  late final String country;
  late final String? state;
  late final List<String> displayAddress;
  late final String? crossStreets;

  Location.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    state = json['state'];
    displayAddress = List.castFrom<dynamic, String>(json['display_address']);
    crossStreets = json['cross_streets'];
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
    data['cross_streets'] = crossStreets;
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

class Hours {
  Hours({
    required this.open,
    required this.hoursType,
    required this.isOpenNow,
  });
  late final List<Open> open;
  late final String hoursType;
  late final bool isOpenNow;

  Hours.fromJson(Map<String, dynamic> json) {
    open = List.from(json['open']).map((e) => Open.fromJson(e)).toList();
    hoursType = json['hours_type'];
    isOpenNow = json['is_open_now'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['open'] = open.map((e) => e.toJson()).toList();
    data['hours_type'] = hoursType;
    data['is_open_now'] = isOpenNow;
    return data;
  }
}

class Open {
  Open({
    required this.isOvernight,
    required this.start,
    required this.end,
    required this.day,
  });
  late final bool isOvernight;
  late final String start;
  late final String end;
  late final int day;

  Open.fromJson(Map<String, dynamic> json) {
    isOvernight = json['is_overnight'];
    start = json['start'];
    end = json['end'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['is_overnight'] = isOvernight;
    data['start'] = start;
    data['end'] = end;
    data['day'] = day;
    return data;
  }
}
