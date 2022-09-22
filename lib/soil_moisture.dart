import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './colors.dart' as color;
import 'watering_plants.dart';

class SoilMoisture extends StatefulWidget {
  @override
  State<SoilMoisture> createState() => _SoilMoistureState();
}

class _SoilMoistureState extends State<SoilMoisture> {
  final url =
      'https://agriculture-tech-solutio-c5d30-default-rtdb.firebaseio.com/.json';
  var soilMoisture = 'Loading...';

  void getSoilMoistureData() {
    try {
      http.get(Uri.parse(url)).then((response) {
        soilMoisture = json.decode(response.body)['soilMoisture'].toString();
        setState(() {
          soilMoisture;
        });
      });
    } catch (error) {
      throw (error);
    }
  }

  @override
  void initState() {
    super.initState();
    getSoilMoistureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      appBar: AppBar(
        title: const Text("Soil Moisture"),
        centerTitle: true,
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 2),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
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
                  Text(
                    "Quantity of Moisture in Soil",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    soilMoisture,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Moisture",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: color.AppColor.homePageContainerTextSmall),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WateringPlants()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              color: color.AppColor.gradientFirst.withOpacity(0.7),
              child: Center(
                child: Text("Watering Plants",
                    style: TextStyle(
                        color: color.AppColor.homePageBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
        onPressed: getSoilMoistureData,
      ),
    );
  }
}
