import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/BezierWidget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_api.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherAPI weatherApi;
  Location location = new Location();
  void get() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    print(currentLocation);
  }

  Future<http.Response> fetchWeather() {
    get();
    return http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=london&appid=f12bc4502948b73ebaca07eeb8d6a6cf');
  }

  void test() async {
    final response = await fetchWeather();
    if (response.statusCode == 200)
      // setState(() {
      // Map<String, dynamic> map = json.decode(response.body);
      setState(() {
        weatherApi = new WeatherAPI.fromJson(json.decode(response.body));
      });
    // });

    print(json.decode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            BezierWidget(
              temp: "${(weatherApi.main.temp - 273.15).floor().toString()}°C",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Icon(
                    FlutterIcons.ios_rainy_ion,
                    size: 70,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  weatherApi.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(15.0),
              margin: EdgeInsets.only(top: 20),
              width: 280,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Minima: "),
                              Text(
                                "${(weatherApi.main.tempMin - 273.15).floor().toString()}°C",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Pressão: "),
                              Text("${weatherApi.main.pressure.toString()}hPa")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Vel. Vento: "),
                              Text("${weatherApi.wind.speed.toString()} km/h")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Maxima: "),
                              Text(
                                "${(weatherApi.main.tempMax - 273.15).floor().toString()}°C",
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Umidade: "),
                              Text("${weatherApi.main.humidity.toString()}%"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("dir. Vento: "),
                              Text("NE"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
