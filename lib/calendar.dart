import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './colors.dart' as color;
import 'package:table_calendar/table_calendar.dart';

class calendar extends StatefulWidget {

  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format){
          setState(() {
            format = _format;
          });
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: color.AppColor.gradientFirst.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
