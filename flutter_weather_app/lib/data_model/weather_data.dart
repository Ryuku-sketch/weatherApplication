///
/// Data class for WeatherAPI
///
class WeatherData {
  const WeatherData(
      {required this.minTemp, required this.maxTemp, required this.rainAmount});

  /// Temperature for next 4 days from jan12
  final List<dynamic> minTemp;

  /// Relative Humidity for next 4 days from jan12
  final List<dynamic> maxTemp;

  /// shortwave_radiation for next 4 days from jan12
  final List<dynamic> rainAmount;

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        minTemp: json['daily']['temperature_2m_min'],
        maxTemp: json['daily']['temperature_2m_max'],
        rainAmount: json['daily']['rain_sum']);
  }

  factory WeatherData.failure() {
    return const WeatherData(minTemp: [], maxTemp: [], rainAmount: []);
  }
}

enum ApiResult {
  success,
  failure;

  bool isSuccess() => this == ApiResult.success;
}
