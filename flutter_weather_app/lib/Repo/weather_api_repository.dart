import 'package:flutter_weather_app/data_model/weather_data.dart';
import 'package:flutter_weather_app/data_model/weather_dio.dart';

///
/// Repository Class
/// Control access to DIO Layer & Populate data for business layers
///
class WeatherAPIRepository {
  final WeatherDio dio = WeatherDio();
  Future<WeatherData> fetchData() async {
    final response = await dio.fetchList();
    final ApiResult resultStatus = dio.apiResultChecker(response);

    // Fetching Failed case
    if (!resultStatus.isSuccess()) {
      return WeatherData.failure();
    }

    final WeatherData weatherData = WeatherData.fromJson(response);

    // storing data failed case
    if (weatherData.maxTemp.isEmpty &&
        weatherData.minTemp.isEmpty &&
        weatherData.rainAmount.isEmpty) {
      return WeatherData.failure();
    }

    return weatherData;
  }
}
