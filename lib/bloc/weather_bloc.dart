import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_search_bloc/model/weather.dart';
import 'package:weather_search_bloc/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(const WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(const WeatherLoading());
      try {
        final Weather weather =
            await _weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather));
      } on NetworkException {
        emit(const WeatherError(
            'Could not fetch weather. Is the device online?'));
      }
    });
  }
}
