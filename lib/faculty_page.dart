import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/faculty_information_section.dart';
import 'package:smapp/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/Student/student_tabs.dart';
import 'package:smapp/screens/faculty_screen.dart';

import 'boxes/boxFaculty.dart';
import 'models/faculty_model.dart';

class FacultyPage extends StatefulWidget {
  const FacultyPage({Key? key}) : super(key: key);

  @override
  State<FacultyPage> createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
  }

  countCashiers() {
    final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    int cashiers = 0;
    for (final faculty in box.values) {
      if (faculty.userFaculty == 'Cashier') {
        cashiers += 1;
      }
    }
    return cashiers;
  }

  @override
  Widget build(BuildContext context) {
    var facultyCount = Hive.box<Faculty>(HiveBoxesFaculty.faculty).length;
    var activeCashiers = countCashiers();
    var percentage = (activeCashiers / facultyCount).toStringAsFixed(2);
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f9),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.63,
                      padding: const EdgeInsets.only(left: 40),
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
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.63,
                        padding: const EdgeInsets.only(left: 40),
                        child: const StudentTabs()),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Faculty',
                              name: 'Enlisted Now',
                              descriptions: 'Database Analytics',
                              progress: 1.0,
                              progressString: '$facultyCount',
                              color: const Color(0xffFAAA1E),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Faculty',
                              name: 'Active Cashiers',
                              descriptions: 'Database Analytics',
                              progress: double.parse(percentage),
                              progressString: '$activeCashiers',
                              color: const Color(0xff6C6CE5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.9,
                        margin: const EdgeInsets.only(left: 25),
                        width: MediaQuery.of(context).size.width * 0.59,
                        child: const FacultyScreen(
                          title: 'title',
                        )),
                  ],
                ),
              ],
            ),
            const NavibarFaculty(),
            const FacultyInfo(),
          ],
        ),
      ),
    );
  }
}
