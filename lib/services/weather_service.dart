import 'dart:convert';

import 'package:weatherapp/models/weather_models.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/api_key.dart';

class WeatherService {
  // constant values {api key, URL, const objs};
  final String baseUrl = "https://api.openweathermap.org/data/2.5";
  final String apiId = openWeatherApiKey;

  // functions
  Future<WeatherModel?> getWeatherData(String cityName) async {
    //url, response(json), conditionaly data fetch(status == 200)
    try {
      String url = "$baseUrl/weather?q=$cityName&appid=$apiId&units=metric";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // success state(data hai)
        Map<String, dynamic> jsonData =
            jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(jsonData);
      } else {
        print("failed here");
        throw Exception("Failed to load the data");
      }
    } catch (e) {
      print("failed here $e");
      throw Exception("Error: $e");
    }
  }
}
