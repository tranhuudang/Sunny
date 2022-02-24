import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var APIkey = "6fc32b4b2a5c4c32e95f4be0e0ee8ed9";

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double temp = 0;
  String describeWeather = "";
  void getWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied)
      print("User not alow to access their location");
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIkey&units=metric"));
    print(response.body);
    temp = jsonDecode(response.body)['main']['temp'];
    describeWeather = jsonDecode(response.body)['weather'][0]['description'];
    print(describeWeather);
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/background.jpg'),

        )
      ),
      child: Center(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                temp.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              
              describeWeather,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                getWeather();
              });

            },
            child: Text("Check the weather"),
          ),
        ],
      )),
    );
  }
}
