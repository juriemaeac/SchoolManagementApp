import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/CalendarSpace/faculty_information_section.dart';
import 'package:smapp/CalendarSpace/student_information_section.dart';
import 'package:smapp/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/NavigationBar/navbar_section.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/Student/student_tabs.dart';
import 'package:smapp/screens/faculty_screen.dart';
import 'package:smapp/screens/students_screen.dart';

class FacultyPage extends StatelessWidget {
  const FacultyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f5f9),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Text(
                        'Faculty Page',
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
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.63,
                        child: StudentTabs()),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width * 0.63,
                        child: ProjectStatisticsCards()),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: Text(
                        'Faculty List',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.9,
                        margin: EdgeInsets.only(left: 25),
                        width: MediaQuery.of(context).size.width * 0.59,
                        child: const FacultyScreen(
                          title: 'title',
                        )),
                  ],
                ),
              ],
            ),
            NavibarFaculty(),
            FacultyInfo(),
          ],
        ),
      ),
    );
  }
}
