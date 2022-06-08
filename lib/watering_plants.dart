import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './colors.dart' as color;

class WateringPlants extends StatefulWidget {
  @override
  State<WateringPlants> createState() => _WateringPlantsState();
}

class _WateringPlantsState extends State<WateringPlants> {
  final url =
      'https://agriculture-tech-solutions-default-rtdb.firebaseio.com/.json';
  var imageFile = 'assets/plants.png';
  var details = 'ON Watering System';
  bool _isWatering;

  void getWateringSystemData() {
    try {
      http.get(Uri.parse(url)).then((response) {
        _isWatering = json.decode(response.body)['wateringSystem'];
        if (_isWatering) {
          imageFile = 'assets/watering-plants.png';
          details = 'OFF Watering System';
          _isWatering = !_isWatering;
        } else {
          imageFile = 'assets/plants.png';
          details = 'ON Watering System';
          _isWatering = !_isWatering;
        }
        setState(() {});
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  void initState() {
    super.initState();
    getWateringSystemData();
  }

  wateringSystemOn() {
    http
        .patch(
      Uri.parse(url),
      body: json.encode({
        'wateringSystem': _isWatering,
      }),
    )
        .then((response) {
      setState(() {
        imageFile = 'assets/watering-plants.png';
        details = 'OFF Watering System';
        _isWatering = !_isWatering;
      });
    });
  }

  wateringSystemOff() {
    http
        .patch(
      Uri.parse(url),
      body: json.encode({
        'wateringSystem': _isWatering,
      }),
    )
        .then((response) {
      setState(() {
        imageFile = 'assets/plants.png';
        details = 'ON Watering System';
        _isWatering = !_isWatering;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      appBar: AppBar(
        title: const Text("Watering Plants"),
        centerTitle: true,
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              color: color.AppColor.gradientFirst.withOpacity(0.1),
              child: imageFile == null
                  ? const Center(
                      child: Text('Watering Plants...'),
                    )
                  : Image.asset(imageFile),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                _isWatering ? wateringSystemOn() : wateringSystemOff();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                color: color.AppColor.gradientFirst.withOpacity(0.7),
                child: Center(
                  child: Text(details,
                      style: TextStyle(
                          color: color.AppColor.homePageBackground,
                          fontSize: 16)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
