import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_home.dart';
import 'package:weather_app/screens/weather_radar.dart';
import 'package:weather_app/screens/weather_search.dart';
import 'package:weather_app/screens/weather_settings.dart';

class WeatherNavigation extends StatefulWidget {
  const WeatherNavigation({super.key});

  @override
  State<WeatherNavigation> createState() => _WeatherNavigationState();
}

class _WeatherNavigationState extends State<WeatherNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    WeatherHome(),
    WeatherSearch(),
    WeatherRadar(),
    WeatherSettings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), 
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Radar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800]!,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}