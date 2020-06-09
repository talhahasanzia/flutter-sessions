import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unittestingdart/weather_model.dart';

Future<WeatherModel> fetchWeather(City city, {http.Client client}) async {
  final response = await client.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=${city.lat}&lon=${city.lng}&appid=bc2ae7b70c1f9e460132efe2434f1fa1&units=metric');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherModel.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class City {
  final double lat;
  final double lng;
  final String name;

  City(this.lat, this.lng, this.name);
}

final KARACHI = City(24.8607, 67.0011, "Karachi");
final LONDON = City(51.5074, 0.1278, "London");
final HARSTAD = City(68.7986, 16.5415, "Harstad");
final KUALALUMPUR = City(3.1390, 101.6869, "Kual Lumpur");
