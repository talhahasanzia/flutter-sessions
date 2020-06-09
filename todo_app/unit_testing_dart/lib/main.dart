import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unittestingdart/ui_state.dart';
import 'package:unittestingdart/weather_model.dart';
import 'package:unittestingdart/weather_service.dart';
import 'package:unittestingdart/weather_state.dart';


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
  WeatherState _state;
  int _currentUiState = -1;
  dynamic _data;
  Function _callback;

  _MyHomePageState() : super() {
    _data = context;
    _callback = onTextClicked;
  }

  @override
  Widget build(BuildContext context) {
    UiState state = getState(_currentUiState);
    _currentUiState = state.getState();
    return state.getUi(_data, _callback);
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

  getWeatherStateFromData(WeatherModel data) => WeatherState(
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
      color = Colors.white;
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
      return null;
    } else {
      return _getWeatherUI();
    }
  }

  void onTextClicked(BuildContext context) {
    _currentCity = LONDON.name;
    _futureWeather = fetchWeather(LONDON);
    _futureWeather.then((value) => {
          setState(() {
            _isDataAvailable = true;
            _state = getWeatherStateFromData(value);
            _data = _state;
          })
        });
  }

  UiState getState(int state) {
    if (!_isDataAvailable && _currentUiState == -1)
      return Selection();
    else if (!_isDataAvailable && _currentUiState == 1) {
      return Loading();
    } else if (_isDataAvailable && _currentUiState == 2) {
      return Weather();
    } else {
      return Error();
    }
  }
}

class Selection implements UiState {
  @override
  int getState() {
    return 1;
  }

  @override
  Widget getUi(data, Function callback) {
    return Container(
      color: Colors.lightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => callback(data as BuildContext),
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
  }
}

class Weather implements UiState {
  @override
  int getState() {
    return 3;
  }

  @override
  Widget getUi(data, Function func) {
    WeatherState state = data as WeatherState;
    return Container(
      color: state.bgColor,
      child: Padding(
        padding: EdgeInsets.only(left: 24, top: 24),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(state.city,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: state.textColor, fontSize: 22)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlutterLogo(),
                  Text(state.temperatureText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: state.textColor, fontSize: 32)),
                  Text(state.weatherText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: state.textColor, fontSize: 18)),
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
}

class Loading implements UiState {
  @override
  int getState() {
    return 2;
  }

  @override
  Widget getUi(data, Function callback) {
    return Container(
      color: Colors.lightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}

class Error implements UiState {
  @override
  int getState() {
    return 3;
  }

  @override
  Widget getUi(data, Function func) {
    return Text("Something went wrong!");
  }
}

