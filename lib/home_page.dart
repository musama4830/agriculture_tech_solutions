import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import './colors.dart' as color;
import './calendar.dart';
import './weather.dart';
import './soil_moisture.dart';
import './live_monitoring.dart';
import './watering_plants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      info = json.decode(value);
    });
  }

  var temp, main, weather, humidity, wind, cityname;
  int value;
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Lahore&units=imperial&appid=35386de90cb54eb2f8e4f96f9b115dde"));
    var results = jsonDecode(response.body);

    setState(() {
      temp = results['main']['temp'];
      main = results['weather'][0]['main'];
      weather = results['weather'][0]['description'];
      humidity = results['main']['humidity'];
      wind = results['wind']['speed'];
      cityname = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
    _initData();
  }

  listViewItem(int value) {
    var page;
    if (value == 0) {
      page = SoilMoisture();
    } else if (value == 1) {
      page = Weather(temp, main, weather, humidity, wind, cityname, value = 1);
    } else if (value == 2) {
      page = LiveMonitoring();
    } else if (value == 3) {
      page = WateringPlants();
    }

    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Column(
          children: [
            widget1(),
            const SizedBox(height: 5),
            widget2(),
            const SizedBox(height: 5),
            widget3(),
            const SizedBox(height: 10),
            widget4(),
            const SizedBox(height: 10),
            widget5(),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
      ),
    );
  }

  widget1() {
    return Row(
      children: [
        Text("Agriculture",
            style: TextStyle(
                fontSize: 30,
                color: color.AppColor.homePageTitle,
                fontWeight: FontWeight.w700)),
        Expanded(child: Container()),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => calendar()));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: Row(children: [
                Icon(Icons.arrow_back_ios,
                    size: 20, color: color.AppColor.homePageIcons),
                const SizedBox(width: 10),
                Icon(Icons.calendar_today_outlined,
                    size: 20, color: color.AppColor.homePageIcons),
                const SizedBox(width: 15),
                Icon(Icons.arrow_forward_ios,
                    size: 20, color: color.AppColor.homePageIcons),
              ]),
            )),
      ],
    );
  }

  widget2() {
    return Row(
      children: [
        Text("Your Program",
            style: TextStyle(
                fontSize: 20,
                color: color.AppColor.homePageTitle,
                fontWeight: FontWeight.w700)),
        Expanded(child: Container()),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Weather(
                      temp, main, weather, humidity, wind, cityname, value = 0),
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: Row(children: [
              Text("Details",
                  style: TextStyle(
                      fontSize: 20, color: color.AppColor.homePageDetails)),
              const SizedBox(width: 5),
              Icon(Icons.arrow_forward,
                  size: 20, color: color.AppColor.homePageIcons),
            ]),
          ),
        )
      ],
    );
  }

  widget3() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          color.AppColor.gradientFirst.withOpacity(0.8),
          color.AppColor.gradientSecond.withOpacity(0.9)
        ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(80)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(5, 10),
              blurRadius: 20,
              color: color.AppColor.gradientSecond.withOpacity(0.2)),
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
                Text("Currently in ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: color.AppColor.homePageContainerTextSmall)),
                Text(cityname != null ? cityname.toString() : 'Loading',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: color.AppColor.homePageContainerTextSmall)),
              ],
            ),
            const SizedBox(height: 15),
            Text(temp != null ? temp.toString() + "\u00B0" : "Loading",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: color.AppColor.homePageContainerTextSmall)),
            const SizedBox(height: 5),
            Text(main != null ? main.toString() : "Loading",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: color.AppColor.homePageContainerTextSmall)),
          ],
        ),
      ),
    );
  }

  widget4() {
    return Row(
      children: [
        Text("Area of Foucs",
            style: TextStyle(
                fontSize: 20,
                color: color.AppColor.homePageTitle,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  widget5() {
    return Expanded(
      child: OverflowBox(
        maxWidth: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: info.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => listViewItem(index),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 70,
                    margin: const EdgeInsets.only(
                        left: 5, bottom: 5, top: 5, right: 5),
                    padding: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(info[index]['img'])),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            offset: const Offset(5, 5),
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.1)),
                        BoxShadow(
                            blurRadius: 3,
                            offset: const Offset(-5, -5),
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.1)),
                      ],
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(info[index]['title'],
                            style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.homePageDetails)),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
