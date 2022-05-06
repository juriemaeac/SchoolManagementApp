import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/boxes/boxSubject.dart';
import 'package:smapp/maintenance_page.dart';
import 'package:smapp/models/subject_model.dart';
import 'package:smapp/screens/edit_screen/editcourse_screen.dart';
import 'package:smapp/screens/edit_screen/editsubject_screen.dart';
import '../models/course_model.dart';
import '../models/faculty_model.dart';

class MaintenanceScreen extends StatefulWidget {
  final String title;
  const MaintenanceScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  bool isSearching = false;
  String? searchCode;
  bool? isEnabled = true;
  int? searchCount = 0;

  @override
  void initState() {
    super.initState();
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
    var user = facultyCredential.getString();
    if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  TextEditingController subjectController = TextEditingController();

  validator(String subCode) {
    Box<Subject> box = Hive.box<Subject>(HiveBoxesSubject.subject);
    var count =
        box.values.where((subject) => subject.subjectCourse == subCode).length;
    if (count > 0) {

      searchCode = subCode;
      isEnabled = false;
      isSearching = true;
    } else {
      isSearching = false;
      subjectController.clear();
    }
    searchCount = count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.56,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.045,
                  width: (MediaQuery.of(context).size.width * 0.56) / 2.19,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Course List',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.0485,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.045,
                  width: (MediaQuery.of(context).size.width * 0.56) / 2.19,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subject List',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    height: 30,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 9,
                                          //offset: Offset(2, 6),
                                          // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      enabled: isEnabled,
                                      controller: subjectController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 11),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        labelText: 'Enter Course Code',
                                        labelStyle: TextStyle(
                                          fontSize: 12,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 65,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(3),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  side: const BorderSide(
                                                      color: Colors.orange)))),
                                      onPressed: () {
                                        String codeVal = subjectController.text;
                                        validator(codeVal);
                                        setState(() {
                                          searchCode = subjectController.text;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const <Widget>[
                                            Icon(
                                              Icons.search_rounded,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                        child: Material(
                                          elevation: 3,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Container(
                                              height: 30,
                                              width: 30,
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff6C6CE5),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: const Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.white,
                                                  size: 15)),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MaintenancePage(),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: (MediaQuery.of(context).size.width * 0.59) / 2.07,
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Course>(HiveBoxesCourse.course).listenable(),
                    builder: (context, Box<Course> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.only(top: 50),
                              child: const Text("Course list is empty")),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              int reverseIndex = box.length - 1 - index;
                              final Course? res = box.getAt(reverseIndex);
                              return ListTile(
                                title: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      //alignment: WrapAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                Column(
                                                  children: [
                                                    Text(
                                                      res!.courseCode +
                                                          ' - Php' +
                                                          res.courseFee
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                Text(
                                                  res.courseName.substring(
                                                      0,
                                                      min(res.courseName.length,
                                                          47)),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 10,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              102,
                                                              101,
                                                              101)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  splashColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  icon: SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: SvgPicture.asset(
                                                      'assets/edit_svg.svg',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Course course = Course(
                                                        courseCode:
                                                            res.courseCode,
                                                        courseName:
                                                            res.courseName,
                                                        courseFee:
                                                            res.courseFee);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditCourseScreen(
                                                          course: course,
                                                          index: reverseIndex,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                // IconButton(
                                                //   padding: const EdgeInsets.all(3.0),
                                                //   splashColor: Colors.transparent,
                                                //   hoverColor: Colors.transparent,
                                                //   icon: SizedBox(
                                                //     height: 60,
                                                //     width: 60,
                                                //     child: SvgPicture.asset(
                                                //       'assets/delete_svg.svg',
                                                //     ),
                                                //   ),
                                                //   onPressed: () {
                                                //     res.delete();
                                                //   },
                                                // ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                // subtitle: Text(res.userFaculty.toString()),
                                // onTap: () {}
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: (MediaQuery.of(context).size.width * 0.59) / 2.07,
                child: ValueListenableBuilder(
                    valueListenable: Hive.box<Subject>(HiveBoxesSubject.subject)
                        .listenable(),
                    builder: (context, Box<Subject> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.only(top: 50),
                              child: const Text("Subject list is empty")),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                isSearching ? searchCount : box.values.length,
                            itemBuilder: (context, index) {
                              int reverseIndex = box.length - 1 - index;
                              final Subject? res = isSearching
                                  ? box.values
                                      .where((subject) =>
                                          subject.subjectCourse == searchCode)
                                      .toList()[index]
                                  : box.getAt(reverseIndex);
                              return ListTile(
                                title: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      //alignment: WrapAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                Column(
                                                  children: [
                                                    Text(
                                                      res!.subjectCode +
                                                          ' : ' +
                                                          '${res.subjectUnit}units'
                                                              .toString(),
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                Text(
                                                  res.subjectCourse +
                                                      ' - ' +
                                                      res.subjectYear +
                                                      ' ' +
                                                      res.subjectTerm,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 13,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              102,
                                                              101,
                                                              101)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  splashColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  icon: SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: SvgPicture.asset(
                                                      'assets/edit_svg.svg',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Subject subject = Subject(
                                                        subjectCourse:
                                                            res.subjectCourse,
                                                        subjectYear:
                                                            res.subjectYear,
                                                        subjectTerm:
                                                            res.subjectTerm,
                                                        subjectCode:
                                                            res.subjectCode,
                                                        subjectUnit:
                                                            res.subjectUnit);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditSubjectScreen(
                                                          subject: subject,
                                                          index: reverseIndex,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  splashColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  icon: SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: SvgPicture.asset(
                                                      'assets/delete_svg.svg',
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    res.delete();
                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                                // subtitle: Text(res.userFaculty.toString()),
                                // onTap: () {}
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
