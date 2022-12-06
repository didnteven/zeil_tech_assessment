import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zeil_tech_assessment/models/restaurant.dart';
import 'package:zeil_tech_assessment/models/restaurant_details.dart';

//Api key (would be stored server side if needed to be a secret)
const String _apiKey =
    'Ak27PeBmQupQY68J_UfP-GCAac7bhD3fhAmyRK_KyN6Xvn0w9DGv8SxaLU5XjqJ83rzJ2rrP4tb1ihyzbQz50bvrzyVPnjomW7VWfd3py1RouUwX2Ok2ORVnDJaNY3Yx';

///Search Yelp API for restaurants with a keyword String
///
///Returns a list of Businesses
Future<List<Business>> searchRestaurants(String searchLocation) async {
  var resultList = <Business>[];
  try {
    var headers = {
      'header': 'accept: application/json',
      'Authorization': 'Bearer $_apiKey'
    };

    final response = await http.get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/search?location=$searchLocation&term=restaurants&sort_by=best_match&limit=20'),
        headers: headers);

    if (response.statusCode == 200) {
      final result = response.body;
      const jsonDecoder = JsonDecoder();
      final jsonResult = jsonDecoder.convert(result);

      final listOfRestaurants = jsonResult['businesses'] as List;

      resultList = listOfRestaurants
          .map((jsonRestaurant) =>
              Business.fromJson(jsonRestaurant as Map<String, dynamic>))
          .toList();
    } else {
      debugPrint(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
    return resultList;
  } on Exception catch (e) {
    throw Exception(e);
  }
}

///Search Yelp API for restaurants with a keyword String
///
///Returns a list of Businesses
Future<RestaurantDetails?> getRestaurantDetails(String businessAlias) async {
  RestaurantDetails? restaurantDetails;

  try {
    var headers = {
      'header': 'accept: application/json',
      'Authorization': 'Bearer $_apiKey'
    };

    final response = await http.get(
        Uri.parse('https://api.yelp.com/v3/businesses/$businessAlias'),
        headers: headers);

    if (response.statusCode == 200) {
      final result = response.body;
      const jsonDecoder = JsonDecoder();
      final jsonResult = jsonDecoder.convert(result);

      restaurantDetails =
          RestaurantDetails.fromJson(jsonResult as Map<String, dynamic>);
    } else {
      debugPrint(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  } on Exception catch (e) {
    throw Exception(e);
  }
  return restaurantDetails;
}
