// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String cityName;
  final double temperatureCelsius;

  const Weather({
    required this.cityName,
    required this.temperatureCelsius,
  });

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName &&
        other.temperatureCelsius == temperatureCelsius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;

  @override
  String toString() =>
      'Weather(cityName: $cityName, temperatureCelsius: $temperatureCelsius)';

  Weather copyWith({
    String? cityName,
    double? temperatureCelsius,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
    );
  }
}
