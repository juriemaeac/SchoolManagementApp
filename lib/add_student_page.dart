import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/CalendarSpace/addstudent_information.dart';
import 'package:smapp/CalendarSpace/information_section.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/screens/addstudents_screen.dart';

class AddStudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    margin: const EdgeInsets.only(left: 130),
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: Text(
                      'Add Student',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 51, 57, 81),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 70,
                      margin: const EdgeInsets.only(left: 100),
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: AddStudentScreen()),
                ],
              ),
            ),
            NavibarStudent(),
            AddStudentInfo(),
          ],
        ),
      ),
    );
  }
}
