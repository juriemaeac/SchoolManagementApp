import 'package:flutter/material.dart';
import 'package:smapp/CalendarSpace/src/calendar_section.dart';
import 'package:smapp/CalendarSpace/src/profile_section.dart';

class AddStudentInfo extends StatelessWidget {
  const AddStudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        color: const Color(0xffF7F7FF),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.28,
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const TopContainer(), //profile
            const SizedBox(
              height: 30.0,
            ),
            const CalendarSection(), //Month Year
            Container(
              height: MediaQuery.of(context).size.height * 0.665,
              width: MediaQuery.of(context).size.width * 0.28,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/design1.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
