import 'package:flutter/material.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';
import 'package:smapp/CalendarSpace/src/student_buttons.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF7F7FF),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 9,
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
            TopContainer(), //profile
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.28,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/girl_read.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            CalendarSection(), //Month Year
            const StudentButtons(),
          ],
        ),
      ),
    );
  }
}
