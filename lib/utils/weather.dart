import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';
import 'package:weather_icons/weather_icons.dart';

var apiKey = "bba471b993cf21244d7e8f50c4569b37";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  late LocationHelper locationData;
  late double currentTemperature;
  late int currentCondition;
  late String city = '';

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API den veri gelmiyor");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon:
              const Icon(WeatherIcons.cloud, size: 75.0, color: Colors.white),
          weatherImage: AssetImage('assets/cloudy-weather.jpg'));
    } else {
      // hava iyi
      // gece gündüz kontrolü
      var now = DateTime.now();
      if (now.hour <= 6 || now.hour > 19) {
        return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.moon,
                size: 75.0, color: Colors.white),
            weatherImage: AssetImage('assets/gece.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(WeatherIcons.day_sunny,
                size: 75.0, color: Colors.yellowAccent),
            weatherImage: AssetImage('assets/güneşli.jpg'));
      }
    }
  }
}
