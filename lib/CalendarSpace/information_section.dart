import 'package:flutter/material.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/recent_transaction.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';

class CalendarSpace extends StatelessWidget {
  const CalendarSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF7F7FF),
          //color: Colors.white,
          //borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 9,
              // changes position of shadow
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          children: const [
            SizedBox(
              height: 30.0,
            ),
            TopContainer(),
            SizedBox(
              height: 30.0,
            ),
            CalendarSection(),
            MeetingsSection(),
          ],
        ),
      ),
    );
  }
}
