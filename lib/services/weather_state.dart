import 'package:weatherapp/models/weather_models.dart';

class WeatherState {
  final bool isLoading;
  final String errorMessage;
  final WeatherModel? weather;

  WeatherState({this.isLoading = false, this.errorMessage = "", this.weather});

  WeatherState copyWith({
    bool? isLoading,
    String? eMessage,
    WeatherModel? weather,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: eMessage ?? errorMessage,
      weather: weather,
    );
  }
}
