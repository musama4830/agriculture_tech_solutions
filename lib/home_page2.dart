// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:get/get.dart';

// import './colors.dart' as color;
// import './calendar.dart';
// import './weather.dart';
// import './soil_moisture.dart';
// import './live_monitoring.dart';
// import './watering_plants.dart';

// class HomePage2 extends StatefulWidget {

//   @override
//   _HomePage2State createState() => _HomePage2State();
// }

// class _HomePage2State extends State<HomePage2> {
//   List info = [];

//   _initData() {
//     DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
//       info = json.decode(value);
//     });
//   }

//   var temp, main, weather, humidity, wind, cityname;

//   Future getWeather() async {
//     http.Response response = await http.get(Uri.parse(
//         "https://api.openweathermap.org/data/2.5/weather?q=Lahore&units=imperial&appid=35386de90cb54eb2f8e4f96f9b115dde"));
//     var results = jsonDecode(response.body);
//     setState(() {
//       this.temp = results['main']['temp'];
//       this.main = results['weather'][0]['main'];
//       this.weather = results['weather'][0]['description'];
//       this.humidity = results['main']['humidity'];
//       this.wind = results['wind']['speed'];
//       this.cityname = results['name'];
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     this.getWeather();
//     _initData();
//   }

//   void listViewItem(int value) {
//     var page;
//     if (value == 0) {
//      page = SoilMoisture();
//     } else if (value == 1) {
//       // page = Weather();
//     } else if (value == 2) {
//       page = LiveMonitoring();
//     } else if (value == 3) {
//       page = WateringPlants();
//     }

//     setState(() {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => page));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: color.AppColor.homePageBackground,
//       body: Container(
//         padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text("Agriculture",
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: color.AppColor.homePageTitle,
//                         fontWeight: FontWeight.w700)),
//                 Expanded(child: Container()),
//                 Icon(Icons.arrow_back_ios,
//                     size: 20, color: color.AppColor.homePageIcons),
//                 const SizedBox(width: 10),
//                 InkWell(
//                     onTap: () {
//                       Get.to(() => calendar());
//                     },
//                     child: Icon(Icons.calendar_today_outlined,
//                         size: 20, color: color.AppColor.homePageIcons)),
//                 const SizedBox(width: 15),
//                 Icon(Icons.arrow_forward_ios,
//                     size: 20, color: color.AppColor.homePageIcons),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Row(
//               children: [
//                 Text("Your Program",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: color.AppColor.homePageTitle,
//                         fontWeight: FontWeight.w700)),
//                 Expanded(child: Container()),
//                 // Text("Details",
//                 //     style: TextStyle(
//                 //         fontSize: 20, color: color.AppColor.homePageDetails)),
//                 const SizedBox(width: 5),
//                 InkWell(
//                   onTap: () {
//                     // Get.to(() => Weather());
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(5),
//                     margin: const EdgeInsets.all(5),
//                     child: Row(
//                       children: [
//                       Text("Details",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: color.AppColor.homePageDetails)),
//                       const SizedBox(width: 5),
//                       Icon(Icons.arrow_forward,
//                           size: 20, color: color.AppColor.homePageIcons),
//                     ]),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 15),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 170,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   color.AppColor.gradientFirst.withOpacity(0.8),
//                   color.AppColor.gradientSecond.withOpacity(0.9)
//                 ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                     topRight: Radius.circular(80)),
//                 boxShadow: [
//                   BoxShadow(
//                       offset: const Offset(5, 10),
//                       blurRadius: 20,
//                       color: color.AppColor.gradientSecond.withOpacity(0.2)),
//                 ],
//               ),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Currently in ",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: color.AppColor.homePageContainerTextSmall),
//                         ),
//                         Text(
//                           cityname != null ? cityname.toString() : 'Loading',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: color.AppColor.homePageContainerTextSmall),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     Text(
//                       temp != null ? temp.toString() + "\u00B0" : "Loading",
//                       style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.w600,
//                           color: color.AppColor.homePageContainerTextSmall),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       main != null ? main.toString() : "Loading",
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: color.AppColor.homePageContainerTextSmall),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Row(
//               children: [
//                 Text("Area of Foucs",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: color.AppColor.homePageTitle,
//                         fontWeight: FontWeight.w700)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: OverflowBox(
//                 maxWidth: MediaQuery.of(context).size.width,
//                 child: MediaQuery.removePadding(
//                   removeTop: true,
//                   context: context,
//                   child: ListView.builder(
//                       itemCount: (info.length.toDouble() / 2).toInt(),
//                       itemBuilder: (_, i) {
//                         int a = 2 * i;
//                         int b = 2 * i + 1;
//                         return Row(
//                           children: [
//                             Container(
//                               width:
//                                   (MediaQuery.of(context).size.width - 55) / 2,
//                               height: 170,
//                               margin:
//                                   const EdgeInsets.only(left: 20, bottom: 5, top: 10),
//                               padding: const EdgeInsets.only(bottom: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 image: DecorationImage(
//                                     image: AssetImage(info[a]['img'])),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 3,
//                                       offset: const Offset(5, 5),
//                                       color: color.AppColor.gradientSecond
//                                           .withOpacity(0.1)),
//                                   BoxShadow(
//                                       blurRadius: 3,
//                                       offset: const Offset(-5, -5),
//                                       color: color.AppColor.gradientSecond
//                                           .withOpacity(0.1)),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: TextButton(
//                                       child: Text(
//                                         info[a]['title'],
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color:
//                                                 color.AppColor.homePageDetails),
//                                       ),
//                                       onPressed: () => listViewItem(a)),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width:
//                                   (MediaQuery.of(context).size.width - 55) / 2,
//                               height: 170,
//                               margin:
//                                   const EdgeInsets.only(left: 15, bottom: 5, top: 10),
//                               padding: const EdgeInsets.only(bottom: 10),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 image: DecorationImage(
//                                     image: AssetImage(info[b]['img'])),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 3,
//                                       offset: const Offset(5, 5),
//                                       color: color.AppColor.gradientSecond
//                                           .withOpacity(0.1)),
//                                   BoxShadow(
//                                       blurRadius: 3,
//                                       offset: const Offset(-5, -5),
//                                       color: color.AppColor.gradientSecond
//                                           .withOpacity(0.1)),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: TextButton(
//                                       child: Text(
//                                         info[b]['title'],
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             color:
//                                                 color.AppColor.homePageDetails),
//                                       ),
//                                       onPressed: () => listViewItem(b)),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }