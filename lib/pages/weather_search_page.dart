import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search_bloc/bloc/weather_bloc.dart';
// import 'package:weather_search_bloc/cubit/weather_cubit.dart';
import 'package:weather_search_bloc/model/weather.dart';
import 'package:weather_search_bloc/repository/weather_repository.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({super.key});

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(FakeWeatherRepository()),
      // create: (_) => WeatherCubit(FakeWeatherRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Weather Search App'),
        ),
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: BlocConsumer<WeatherBloc, WeatherState>(
                // child: BlocConsumer<WeatherCubit, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (_, state) {
                  if (state is WeatherInitial) {
                    return _buildInitialInput();
                  } else if (state is WeatherLoading) {
                    return _buildLoading();
                  } else if (state is WeatherLoaded) {
                    return _buildColumnWithData(state.weather);
                  } else {
                    return _buildInitialInput();
                  }
                },
              )),
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

  Column _buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
          style: const TextStyle(
            fontSize: 80,
          ),
        ),
        const CityInputField(),
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

  // void _search(BuildContext context, String city) {
  //   final weatherCubit = context.read<WeatherCubit>();
  //   weatherCubit.fetchWeather(city);
  // }

  void _search(BuildContext context, String city) {
    final weatherBloc = context.read<WeatherBloc>();
    weatherBloc.add(FetchWeather(city));
  }
}
