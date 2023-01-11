import 'package:dio/dio.dart';
import 'package:flutter_weather_app/data_model/weather_data.dart';

/// API Handling class
class WeatherDio {
  static final _instance = WeatherDio._internal();
  factory WeatherDio() {
    return _instance;
  }

  WeatherDio._internal();
  final Dio dioClient = Dio();

  ///
  /// Fetch Data from Web
  ///
  Future<dynamic> fetchList() async {
    const url =
        'https://api.open-meteo.com/v1/forecast?latitude=35.69&longitude=139.69&daily=temperature_2m_max,temperature_2m_min,rain_sum&timezone=Asia%2FTokyo&start_date=2023-01-12&end_date=2023-01-15';

    try {
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  ///
  /// Check whether the fetching succeeded or not
  ///
  ApiResult apiResultChecker(dynamic data) {
    if (data != null) {
      return ApiResult.success;
    }
    return ApiResult.failure;
  }
}
