import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:logging/logging.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {

  // Initialize logger 
  final Logger _logger = Logger('WeatherPage');

  // api key
  final _weatherService = WeatherService('e7b78f4eda017e04b8242189187b04d5');
  Weather? _weather;


  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();
    _logger.info('Current city: $cityName');

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      _logger.info('Weather data: ${weather.conditionCode}');
      setState(() {
        _weather = weather;
      });
    }

    catch (e) {
      _logger.severe('Error fetching weather: $e');
    }
  }
  // weather name
  String getWeatherConditionName(int? conditionCode) {
    if(conditionCode == null) return 'Unknown'; // default

    switch(conditionCode) {
      // Thunderstorm
      case 200:
      case 201: 
      case 202: 
      case 210: 
      case 211: 
      case 212: 
      case 221: 
      case 230: 
      case 231: 
      case 232:
        return 'Thunderstorm';
      // Drizzle & Rain
      case 300: 
      case 301: 
      case 302: 
      case 310: 
      case 311: 
      case 312: 
      case 313: 
      case 314: 
      case 321:
        return 'Drizzle';
      case 500: 
      case 501: 
      case 502: 
      case 503: 
      case 504: 
      case 511: 
      case 520: 
      case 521: 
      case 522: 
      case 531:
        return 'Rain';
      // Snow
      case 600: 
      case 601: 
      case 602: 
      case 611: 
      case 612: 
      case 613: 
      case 615: 
      case 616: 
      case 620: 
      case 621: 
      case 622:
        return 'Snow';
      // Mist, Fog, Smoke, etc
      case 701: 
      case 711: 
      case 721: 
      case 731: 
      case 741: 
      case 751: 
      case 761: 
      case 762: 
      case 771: 
      case 781:
        return 'Mist';
      // Clear
      case 800:
        return 'Clear';
      // Clouds
      case 801: 
      case 802: 
      case 803: 
      case 804:
        return 'Clouds';
      default:
        return 'Unknown';
    }
  }

  // weather animations
  String getWeatherAnimation(int? conditionCode, bool isDayTime) {
    if(conditionCode == null) return 'assets/sunny.json'; // default to sunny

    switch(conditionCode) {
      // Thunderstorm
      case 200:
      case 201: 
      case 202: 
      case 210: 
      case 211: 
      case 212: 
      case 221: 
      case 230: 
      case 231: 
      case 232:
        return 'assets/thunder.json';
      // Drizzle & Rain
      case 300: 
      case 301: 
      case 302: 
      case 310: 
      case 311: 
      case 312: 
      case 313: 
      case 314: 
      case 321:
      case 500: 
      case 501: 
      case 502: 
      case 503: 
      case 504: 
      case 511: 
      case 520: 
      case 521: 
      case 522: 
      case 531:
        return isDayTime ? 'assets/rain_day.json' : 'assets/rain_night.json';
      // Snow
      case 600: 
      case 601: 
      case 602: 
      case 611: 
      case 612: 
      case 613: 
      case 615: 
      case 616: 
      case 620: 
      case 621: 
      case 622:
        return isDayTime ? 'assets/snow_day.json' : 'assets/snow_night.json';
      // Mist, Fog, Smoke, etc
      case 701: 
      case 711: 
      case 721: 
      case 731: 
      case 741: 
      case 751: 
      case 761: 
      case 762: 
      case 771: 
      case 781:
        return 'assets/mist.json';
      // Clear
      case 800:
        return 'assets/sunny.json';
      // Clouds
      case 801: 
      case 802: 
      case 803: 
      case 804:
        return isDayTime ? 'assets/cloudy_day.json' : 'assets/cloudy_night.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // Day and Night mode
  Color getBackgroundColor(int? conditionCode, bool isDayTime) {
    if(conditionCode == null) return isDayTime? Colors.blue[200]! : Colors.grey[800]!; // default for day

    switch(conditionCode) {
      // Thunderstorm
      case 200:
      case 201: 
      case 202: 
      case 210: 
      case 211: 
      case 212: 
      case 221: 
      case 230: 
      case 231: 
      case 232:
        return isDayTime ? Colors.grey[700]! : const Color.fromRGBO(29, 26, 66, 0.945);
      // Drizzle & Rain
      case 300: 
      case 301: 
      case 302: 
      case 310: 
      case 311: 
      case 312: 
      case 313: 
      case 314: 
      case 321:
      case 500: 
      case 501: 
      case 502: 
      case 503: 
      case 504: 
      case 511: 
      case 520: 
      case 521: 
      case 522: 
      case 531:
        return isDayTime ? Colors.grey[500]! : const Color.fromRGBO(29, 26, 66, 0.945);

      // Snow
      case 600: 
      case 601: 
      case 602: 
      case 611: 
      case 612: 
      case 613: 
      case 615: 
      case 616: 
      case 620: 
      case 621: 
      case 622:
        return isDayTime ? Colors.grey[500]! : const Color.fromRGBO(29, 26, 66, 0.945);
      // Mist, Fog, Smoke, etc
      case 701: 
      case 711: 
      case 721: 
      case 731: 
      case 741: 
      case 751: 
      case 761: 
      case 762: 
      case 771: 
      case 781:
        return isDayTime ? Colors.grey[400]! : const Color.fromRGBO(29, 26, 66, 0.945);
      // Clear
      case 800:
        return isDayTime ? Colors.blue[200]! : const Color.fromRGBO(29, 26, 66, 0.945);
      // Clouds
      case 801: 
      case 802: 
      case 803: 
      case 804:
        return isDayTime ? Colors.grey[400]! : const Color.fromRGBO(29, 26, 66, 0.945);
      default:
        return isDayTime ? Colors.blue[200]! : Colors.grey[800]!;
    }
  }

  bool isDayTime() {
    final int hour = DateTime.now().hour;
     return hour >= 6 && hour < 18; // test for day
      
    // return hour <= 6 && hour > 18; // test for night
      
  }

  Color getTextColor(bool isDayTime) { 
    return isDayTime ? Colors.black : Colors.white; 
  }
  
  // init state
  @override
  void initState() {
    super.initState();


    // fetch weather
    _fetchWeather();
  }



  @override
  Widget build(BuildContext context) {
    bool dayTime = isDayTime();
    return Scaffold(
      backgroundColor: getBackgroundColor(_weather?.conditionCode, dayTime),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // city name
            Padding( 
              padding: const EdgeInsets.all(100.0), 
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [ 
                  Icon(Icons.location_on, size: 24, color: getTextColor(dayTime)), 
                  const SizedBox(width: 8), 
                  Text( _weather?.cityName ?? "loading city..", 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: getTextColor(dayTime)), 
                  ), 
                ], 
              ), 
            ),
            
            // animation
            Expanded(
              child: Center(
                child: Lottie.asset(getWeatherAnimation(_weather?.conditionCode, dayTime)),
              ),
            ),
  
            // temperature
            Padding( 
              padding: const EdgeInsets.all(16.0), 
              child: Text('${_weather?.temperature.round()}°F',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: getTextColor(dayTime))),
            ),

            // weather condition
            Padding( 
              padding: const EdgeInsets.all(16.0), 
              child: Text(getWeatherConditionName(_weather?.conditionCode), 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: getTextColor(dayTime))),
            ),
          ],
        ),
      )
    );
  }
}