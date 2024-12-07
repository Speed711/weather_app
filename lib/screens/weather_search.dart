import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherSearch extends StatefulWidget {
  const WeatherSearch({super.key});

  @override
  State<WeatherSearch> createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  final TextEditingController _controller = TextEditingController();
  String _weatherInfo = 'Enter a city to get the weather';
  final WeatherService _weatherService = WeatherService(
      'e7b78f4eda017e04b8242189187b04d5'); // Replace with your actual API key

  void _searchWeather() async {
    String city = _controller.text;
    if (city.isNotEmpty) {
      try {
        Weather weatherData = await _weatherService.getWeather(city);
        setState(() {
          _weatherInfo =
              'Weather in $city: ${weatherData.cityName}, ${weatherData.temperature}°F, Condition Code: ${weatherData.conditionCode}';
        });
      } catch (e) {
        setState(() {
          _weatherInfo = 'Failed to load weather data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter City',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchWeather,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Text(
              _weatherInfo,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
