import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/faculty_information_section.dart';
import 'package:smapp/CalendarSpace/maintenance_information_section.dart';
import 'package:smapp/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/NavigationBar/navbar_maintenance_page.dart';
import 'package:smapp/Dashboard/src/subtitle.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxSubject.dart';
import 'package:smapp/models/subject_model.dart';
import 'package:smapp/screens/faculty_screen.dart';
import 'package:smapp/screens/maintenance_screen.dart';

import 'boxes/boxFaculty.dart';
import 'models/course_model.dart';
import 'models/faculty_model.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
  }


  

  @override
  Widget build(BuildContext context) {
    var courseCount = Hive.box<Course>(HiveBoxesCourse.course).length;
    var subjectsCount = Hive.box<Subject>(HiveBoxesSubject.subject).length;
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
                        'Maintenance Page',
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
                              count: 'Courses',
                              name: 'Listed Now',
                              descriptions: 'Database Analytics',
                              progress: 1.0,
                              progressString: '$courseCount',
                              color: const Color(0xffFAAA1E),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Subjects',
                              name: 'Listed Now',
                              descriptions: 'Database Analytics',
                              progress: 1.0,
                              progressString: '$subjectsCount',
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
                        width: (MediaQuery.of(context).size.width * 0.59),
                        child: const MaintenanceScreen(
                          title: 'title',
                        )),
                  ],
                ),
              ],
            ),
            const NavibarMaintenance(),
            const MaintenanceInfo(),
          ],
        ),
      ),
    );
  }
}
