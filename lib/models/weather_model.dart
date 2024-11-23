class Weather {
  final String cityName;
  final double temperature;
  final int conditionCode;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.conditionCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      conditionCode: json['weather'][0]['id'],
    );
  }
}