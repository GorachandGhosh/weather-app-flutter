import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
