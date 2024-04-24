import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backGroundImage;
  late String city;

  void UpdateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backGroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      city = weatherData.city;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backGroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '$temperature°',
                style: const TextStyle(
                    color: Colors.white, fontSize: 80, letterSpacing: -5),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                city,
                style: const TextStyle(
                    color: Colors.white, fontSize: 50, letterSpacing: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
