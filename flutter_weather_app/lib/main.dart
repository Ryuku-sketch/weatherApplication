import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Repo/weather_api_repository.dart';
import 'package:flutter_weather_app/data_model/weather_data.dart';

void main() {
  runApp(const MyApp());
}

///
/// DIO practice:
///   - Use https://open-meteo.com/
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _average = 0;
  final WeatherAPIRepository repository = WeatherAPIRepository();
  WeatherData data = WeatherData.failure();

  /// Calculate an Average max temp
  double ave(WeatherData weatherData) =>
      weatherData.maxTemp.reduce((a, b) => a + b) / weatherData.maxTemp.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  data = await repository.fetchData();
                  debugPrint('data.minTemp: ${data.minTemp}');
                  debugPrint('data.maxTemp: ${data.maxTemp}');
                  debugPrint('data.rainAmount: ${data.rainAmount}');
                  setState(() {
                    _average = ave(data);
                  });
                },
                child: const Text(
                  'Fetch Data from WebAPI:',
                )),
            Text(
              '$_average',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  'minTemp:${data.maxTemp}, \n maxTemp:${data.minTemp} \n rainAmount:${data.rainAmount}'),
            )
          ],
        ),
      ),
    );
  }
}
