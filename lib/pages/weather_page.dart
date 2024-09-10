import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/const.dart';
import 'package:weather_app/pages/notification_sheet.dart';
import 'package:weather_app/pages/search_city.dart';
import 'package:weather_app/pages/weather_forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  String _selectedCity = "Islamabad";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    _wf.currentWeatherByCityName(_selectedCity).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _onCitySelected(String city) {
    setState(() {
      _selectedCity = city;
      _fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00c6fb),
              Color(0xFF005bea),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        _topBar(context),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _weatherIcon(), // Added weather icon
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _weatherInfoContainer(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _forecastReportButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'icons/location.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CitySelectionPage(
                        onCitySelected: _onCitySelected,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      _selectedCity,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      'icons/arrow_down.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => const NotificationsSheet(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherIcon() {
    String iconCode = _weather?.weatherIcon ?? "01d";

    // Base URL for OpenWeatherMap icons
    String baseUrl = "http://openweathermap.org/img/wn/";

    // Construct the icon URL
    String iconUrl = "$baseUrl$iconCode.png";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0), // Adjust padding as needed
      child: Image.network(
        iconUrl,
        width: 100, // Increase width
        height: 100, // Increase height
        fit: BoxFit.contain, // Adjust to fit the container
      ),
    );
  }

  Widget _weatherInfoContainer() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          _dateTimeInfo(),
          const SizedBox(height: 16),
          _currentTemp(),
          const SizedBox(height: 10),
          _weatherDescription(),
          const SizedBox(height: 20),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("EEEE, d MMMM").format(now),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 75,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _weatherDescription() {
    return Text(
      _weather?.weatherDescription?.toUpperCase() ?? "CLEAR",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _extraInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _infoTile(Icons.air, "Wind", "${_weather?.windSpeed?.toStringAsFixed(1)} km/h"),
        _verticalDivider(),
        _infoTile(Icons.opacity, "Hum", "${_weather?.humidity?.toStringAsFixed(0)}%"),
      ],
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 1,
        height: 40,
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }

  Widget _forecastReportButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForecastScreen()),
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Forecast report",
              style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, color: Color(0xFF4A4A4A)),
          ],
        ),
      ),
    );
  }
}
