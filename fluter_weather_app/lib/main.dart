import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      home: WeatherMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherMainScreen extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherMainScreen> {
  String city = 'Muridke';
  double temperature = 0.0;
  String description = "";
  bool isLoading = false;

  final String apiKey = '08eb397c4dd6194671857f056af3b5c9';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });

    final url = Ur.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          temperature = data['main']['temp'];
          description = data['weather'][0]['description'];
          isLoading = false;
        });
      } else {
        showError("City not found");
      }
    } catch (e) {
      showError("Error fetching data");
    }
  }

  void showError(String msg) {
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Weather')),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  city = value;
                });
                fetchWeather();
              },
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else
              Column(
                children: [
                  Text(
                    city,
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${temperature.toStringAsFixed(1)} °C',
                    style: TextStyle(fontSize: 26),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}