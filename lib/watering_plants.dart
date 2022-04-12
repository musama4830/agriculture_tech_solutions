
import 'package:flutter/material.dart';

import './colors.dart' as color;

class WateringPlants extends StatefulWidget {
  @override
  State<WateringPlants> createState() => _WateringPlantsState();
}

class _WateringPlantsState extends State<WateringPlants> {
  var imageFile = 'assets/plants.png';
  var details = 'ON Watering System';
  var value = 0;

  wateringSystemOn() {
    setState(() {
      imageFile = 'assets/watering-plants.png';
      details = 'OFF Watering System';
      value = 1;
    });
  }

  wateringSystemOff() {
    setState(() {
      imageFile = 'assets/plants.png';
      details = 'ON Watering System';
      value = 0;
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
                value != 1
                ? wateringSystemOn()
                : wateringSystemOff();
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
