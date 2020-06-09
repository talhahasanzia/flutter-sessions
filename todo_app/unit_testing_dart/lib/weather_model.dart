import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {

  WeatherModel({this.weather, this.main});

  final List<Weather> weather;

  final Main main;

  double getTemp(){
    var temp = 0.0;

    if(main !=null){
      temp = (main.temp);
    }

    return temp;
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class Weather{

  Weather({this.description});

  final String description;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

}

@JsonSerializable()
class Main{

  final double temp;
  final double pressure;
  final double humidity;

  Main({this.temp, this.pressure, this.humidity});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);


}
