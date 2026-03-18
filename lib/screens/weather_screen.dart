import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/providers/weather_provider.dart';
import 'package:weatherapp/services/weather_state.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController cityEditingController = TextEditingController();

  void _fetchWeather() {
    ref.read(weatherProvider.notifier).getWeather(cityEditingController.text);
  }

  String formatTemperature(double temp) {
    return '${temp.round()}°C';
  }

  @override
  Widget build(BuildContext context) {
    final WeatherState weatherState = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter City Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 16, width: 16),
                  TextField(
                    controller: cityEditingController,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'e.g., Delhi, Mumbai, London',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue[600]!,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue[600]!,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.blue[600]),
                    ),
                  ),
                  SizedBox(height: 16, width: 16),
                  weatherState.isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _fetchWeather,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Get Weather"),
                          ),
                        ),
                  // temp text
                  if (weatherState.weather != null)
                    Text(
                      'resp: ${weatherState.weather!.condition.description}',
                    ),
                ],
              ),
            ),

            // Weather data or error message
            if (weatherState.errorMessage.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[300]!),
                ),
                child: Text(weatherState.errorMessage),
              ),
            if (weatherState.weather != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[600]!, Colors.blue[800]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // City name and country
                    Text(
                      '${weatherState.weather!.cityName}, ${weatherState.weather!.countryName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Weather Description
                    Text(
                      weatherState.weather!.condition.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Main Temperature
                    Text(
                      formatTemperature(weatherState.weather!.main.temperature),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Feels Like Temperature
                    Text(
                      'Feels like ${weatherState.weather!.main.feelsLike}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 20),

            // Weather Details Grid
            if (weatherState.weather != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weather Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Details Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildDetailCard(
                          icon: Icons.thermostat,
                          title: 'Min Temp',
                          value: formatTemperature(
                            weatherState.weather!.main.tempMin,
                          ),
                          color: Colors.blue[600]!,
                        ),
                        _buildDetailCard(
                          icon: Icons.thermostat,
                          title: 'Max Temp',
                          value: formatTemperature(
                            weatherState.weather!.main.tempMax,
                          ),
                          color: Colors.orange[600]!,
                        ),
                        _buildDetailCard(
                          icon: Icons.water_drop,
                          title: 'Humidity',
                          value: '${weatherState.weather!.main.humidity}%',
                          color: Colors.cyan[600]!,
                        ),
                        _buildDetailCard(
                          icon: Icons.speed,
                          title: 'Pressure',
                          value: '${weatherState.weather!.main.pressure} hPa',
                          color: Colors.purple[600]!,
                        ),
                        _buildDetailCard(
                          icon: Icons.cloud,
                          title: 'Condition',
                          value: weatherState.weather!.condition.main,
                          color: Colors.green[600]!,
                        ),
                        _buildDetailCard(
                          icon: Icons.favorite,
                          title: 'Feels Like',
                          value: formatTemperature(
                            weatherState.weather!.main.feelsLike,
                          ),
                          color: Colors.pink[600]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (weatherState.weather == null &&
                weatherState.errorMessage.isEmpty &&
                !weatherState.isLoading)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.wb_sunny, size: 64, color: Colors.blue[300]),
                    SizedBox(height: 16),
                    Text(
                      'Welcome! to Weather App.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter a city name above to get current weather information',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
