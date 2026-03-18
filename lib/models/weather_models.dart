import 'package:weatherapp/models/main_weatherdata.dart';
import 'package:weatherapp/models/weather_condition.dart';

/*class WindData {
  final double speed;
  final int degree;
  final double gust;

  WindData({required this.speed, required this.degree, required this.gust});
} */

class WeatherModel {
  final String cityName;
  final String countryName;
  final WeatherCondition condition;
  final MainWeatherData main;
  //final WindData wind;
  WeatherModel({
    required this.cityName,
    required this.countryName,
    required this.condition,
    required this.main,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
    : cityName = json['name'],
      countryName = json['sys']['country'],
      condition = WeatherCondition.fromJson(json),
      main = MainWeatherData.fromJson(json);
}
