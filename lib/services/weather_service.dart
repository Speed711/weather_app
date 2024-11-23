import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  
  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseURL?q=$cityName&appid=$apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to load weather data');

    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();


    // get permission from user
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current weather
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100, // minimum to trigger new location event
      ));

    
    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);


    // extract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }
}