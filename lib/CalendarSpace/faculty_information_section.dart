import 'package:flutter/material.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/faculty_buttons.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';

class FacultyInfo extends StatelessWidget {
  const FacultyInfo({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const TopContainer(), //profile
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.28,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/boy_laptop.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            const CalendarSection(), //Month Year
            const FacultyButtons(),
          ],
        ),
      ),
    );
  }
}
