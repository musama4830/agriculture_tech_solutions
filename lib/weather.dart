import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './colors.dart' as color;

class Weather extends StatelessWidget {
  var temp, main, weather, humidity, wind, cityname;
  int value;
  Weather(
    this.temp,
    this.main,
    this.weather,
    this.humidity,
    this.wind,
    this.cityname,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      appBar: AppBar(
        title: value == 0
                  ? const Text("Weather Forecast")
                  : const Text("Humidity Level"),
        centerTitle: true,
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 2),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.AppColor.gradientFirst.withOpacity(0.8),
                  color.AppColor.gradientSecond.withOpacity(0.9),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 10),
                  blurRadius: 20,
                  color: color.AppColor.gradientSecond.withOpacity(0.2),
                ),
              ],
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Currently in ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                        ),
                        Text(
                          cityname != null ? cityname.toString() : "Loading",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 25),
                  Text(
                    value == 0
                    ? temp != null ? temp.toString() + "\u00B0" : "Loading"
                    : humidity != null ? humidity.toString() : "Loading",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: color.AppColor.homePageContainerTextSmall,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    value == 0
                    ? main != null ? main.toString() : "Loading"
                    : "Humidity",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color.AppColor.homePageContainerTextSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: const Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.cloud),
                    title: const Text("Weather"),
                    trailing: Text(weather != null ? weather.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.sun),
                    title: const Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.wind),
                    title: const Text("Wind Speed"),
                    trailing: Text(wind != null ? wind.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
