import 'package:flutter/material.dart';
import 'package:weather_search_bloc/repository/weather_repository.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({super.key});

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Weather Search App'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: _buildInitialInput(),
        ),
      ),
    );
  }

  Widget _buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildColumnWithData() {
    return Column(
      children: [
        const CityInputField(),
        // TODO
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (city) => _search(context, city),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void _search(BuildContext context, String city) async {
    WeatherRepository weatherRepository = FakeWeatherRepository();
    final result = await weatherRepository.fetchWeather(city);
    print(result);
  }
}
