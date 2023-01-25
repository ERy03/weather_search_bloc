import 'package:flutter/material.dart';
import 'package:weather_search_bloc/pages/weather_search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Search App',
      home: WeatherSearchPage(),
    );
  }
}
