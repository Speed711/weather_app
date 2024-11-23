import 'package:flutter/material.dart';

class WeatherRadar extends StatelessWidget {
  const WeatherRadar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radar'),
      ),
      body: const Center(
        child: Text(
          'Radar Page',
        style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}