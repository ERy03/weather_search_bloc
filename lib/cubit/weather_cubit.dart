import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_search_bloc/model/weather.dart';
import 'package:weather_search_bloc/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> fetchWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(
          const WeatherError('Could not fetch weather. Is the device online?'));
    }
  }
}
