import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWeekly extends StatefulWidget {
  const CalendarWeekly({Key? key}) : super(key: key);

  @override
  State<CalendarWeekly> createState() => _CalendarWeeklyState();
}

class _CalendarWeeklyState extends State<CalendarWeekly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.23,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TableCalendar(
        headerVisible: false,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.week,
        calendarStyle: CalendarStyle(
          todayTextStyle: TextStyle(fontSize: 12),
          defaultTextStyle: TextStyle(fontSize: 12),
          weekendTextStyle: TextStyle(fontSize: 12),
          todayDecoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          defaultDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7.5,
                  spreadRadius: 1.0,
                  color: Colors.black12,
                ),
              ]),
          weekendDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7.5,
                  spreadRadius: 1.0,
                  color: Colors.black12,
                ),
              ]),
        ),
      ),
    );
  }
}
