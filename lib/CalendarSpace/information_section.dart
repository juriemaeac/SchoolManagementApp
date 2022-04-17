import 'package:flutter/material.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/recent_transaction.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';

class CalendarSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        color: Color(0xffF7F7FF),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            TopContainer(),
            CalendarSection(),
            MeetingsSection(),
          ],
        ),
      ),
    );
  }
}
