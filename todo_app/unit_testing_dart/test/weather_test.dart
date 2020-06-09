// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:unittestingdart/weather_service.dart' as weather_service;

import '../lib/weather_model.dart';
import '../lib/weather_service.dart';

void main() {
  group('fetch weather', () {
    test('Successful weather response', () async {
      final client = MockClient();
      final city = weather_service.LONDON;

      when(client.get(
              'https://api.openweathermap.org/data/2.5/weather?lat=${city.lat}&lon=${city.lng}&appid=bc2ae7b70c1f9e460132efe2434f1fa1&units=metric'))
          .thenAnswer((_) async => http.Response(response, 200));

      expect(await fetchWeather(LONDON, client: client), isA<WeatherModel>());
    });

    test('Successful temperature', () async {
      final client = MockClient();
      final city = weather_service.LONDON;

      when(client.get(
              'https://api.openweathermap.org/data/2.5/weather?lat=${city.lat}&lon=${city.lng}&appid=bc2ae7b70c1f9e460132efe2434f1fa1&units=metric'))
          .thenAnswer((_) async => http.Response(response, 200));

      weather_service.fetchWeather(city, client: client).then((weather) {
        assert(weather.getTemp() == 15.21);
      });
    });

    test('Failure response', () async {
      final client = MockClient();
      final city = weather_service.LONDON;

      when(client.get(
              'https://api.openweathermap.org/data/2.5/weather?lat=${city.lat}&lon=${city.lng}&appid=bc2ae7b70c1f9e460132efe2434f1fa1&units=metric'))
          .thenAnswer((_) async => http.Response(response, 400));

      expect(await fetchWeather(LONDON, client: client), throwsException);
    });
  });
}

class MockClient extends Mock implements http.Client {}

final response =
    '{"coord":{"lon":0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"stations","main":{"temp":15.21,"feels_like":11.41,"temp_min":15,"temp_max":15.56,"pressure":1019,"humidity":54},"visibility":10000,"wind":{"speed":4.1,"deg":340},"clouds":{"all":20},"dt":1591633310,"sys":{"type":1,"id":1414,"country":"GB","sunrise":1591587814,"sunset":1591647233},"timezone":3600,"id":7302135,"name":"Abbey Wood","cod":200}';
