import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/student_information_section.dart';
import 'package:smapp/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:smapp/Dashboard/src/subtitle.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/screens/student_screen.dart';

import 'models/student_model.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
  }

  countUnpaid() {
    final box = Hive.box<Student>(HiveBoxesStudent.student);
    int unpaid = 0;
    for (final student in box.values) {
      if (student.accountBalance > 0) {
        unpaid += 1;
      }
    }
    return unpaid;
  }

  @override
  Widget build(BuildContext context) {
    var studentCount = Hive.box<Student>(HiveBoxesStudent.student).length;
    var unpaidStudents = countUnpaid();
    var percentage = (unpaidStudents / studentCount).toStringAsFixed(2);
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
                        'Student Page',
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
                              count: 'Students',
                              name: 'Enrolled Now',
                              descriptions: 'Database Analytics',
                              progress: 1.0,
                              progressString: '$studentCount',
                              color: const Color(0xffFAAA1E),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: ProjectStatisticsCard(
                              count: 'Students',
                              name: 'with Unsettled Balance',
                              descriptions: 'Database Analytics',
                              progress: double.parse(percentage),
                              progressString: '$unpaidStudents',
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
                        child: const StudentScreen(
                          title: 'title',
                        )),
                  ],
                ),
              ],
            ),
            const NavibarStudent(),
            const StudentInfo(),
          ],
        ),
      ),
    );
  }
}
