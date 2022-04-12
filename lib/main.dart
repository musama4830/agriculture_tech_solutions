import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import './home_page.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: ('Sample App'),
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(),
    );
  }
}