import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/ui_state.dart';
import 'package:weatherapp/weather_model.dart';
import 'package:weatherapp/weather_service.dart';

import 'weather_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentCity = KARACHI.name;
  Future<WeatherModel> _futureWeather;
  var _isDataAvailable = false;
  WeatherState _state = WeatherState(Colors.black, Colors.white, "Clouds", "78.9", "HKE");

  @override
  Widget build(BuildContext context) {
    return getUi();
  }

  void showError() {
    Fluttertoast.showToast(
        msg: "Cannot fetch weather at this time",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Widget _getWeatherUI() {
    return Container(
      color: _state.bgColor,
      child: Padding(
        padding: EdgeInsets.only(left: 24, top: 24),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(_state.city,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: _state.textColor, fontSize: 22)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlutterLogo(),
                  Text(_state.temperatureText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _state.textColor, fontSize: 32)),
                  Text(_state.weatherText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _state.textColor, fontSize: 18)),
                ],
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }

  getUiStateFromWeatherData(WeatherModel data) => WeatherState(
      getTextColor(data.getTemp()),
      getBgColor(data.getTemp()),
      getWeatherText(data),
      getTemperatureText(data.getTemp()),
      _currentCity);

  Color getTextColor(double temp) {
    Color color;
    if (temp < 1) {
      color = Colors.white;
    } else if (temp >= 1 && temp <= 10) {
      color = Colors.black54;
    } else if (temp > 10 && temp <= 30) {
      color = Colors.black;
    } else {
      color = Colors.deepPurple;
    }

    return color;
  }

  Color getBgColor(double temp) {
    Color color;
    if (temp < 1) {
      color = WeatherColors.FREEZING_BLUE;
    } else if (temp >= 1 && temp <= 10) {
      color = WeatherColors.COOL_BLUE;
    } else if (temp > 10 && temp <= 30) {
      color = WeatherColors.COOL_BLUE;
    } else {
      color = WeatherColors.SUNNY_YELLOW;
    }

    return color;
  }

  String getWeatherText(WeatherModel data) {
    return data.weather.first.description;
  }

  String getTemperatureText(double temp) {
    return "$temp °C";
  }

  Widget getUi() {
    if (!_isDataAvailable) {
      return Container(
        color: Colors.lightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => onTextClicked(context, ""),
                child: Text(
                  "Select City",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      _getWeatherUI();
    }
  }

  onTextClicked(BuildContext context, String route) {
    _futureWeather = fetchWeather(KARACHI);
    _futureWeather.then((value) => {
          setState(() {
            _isDataAvailable = true;
            _state = getUiStateFromWeatherData(value);
          })
        });
  }
}
