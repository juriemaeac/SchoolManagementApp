import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxCourse.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/boxes/boxSubject.dart';
import 'package:smapp/models/subject_model.dart';
import 'package:smapp/screens/edit_screen/editcourse_screen.dart';
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
  String? searchUsername;
  bool? isEnabled = true;

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

  TextEditingController facultyController = TextEditingController();

  validator(String username) {
    Box<Faculty> box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    var count =
        box.values.where((faculty) => faculty.username == username).length;
    if (count > 0) {
      searchUsername = username;
      isEnabled = false;
      isSearching = true;
    } else {
      isSearching = false;
      facultyController.clear();
    }
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
                Container(
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
                Container(
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
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: (MediaQuery.of(context).size.width * 0.59) / 2.07,
                child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Course>(HiveBoxesCourse.course).listenable(),
                    builder: (context, Box<Course> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.only(top: 120),
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
                                                          ' - ' +
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
                                                  res.courseName,
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
                                                          index: index,
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
                                                const SizedBox(width: 20),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: (MediaQuery.of(context).size.width * 0.59) / 2.07,
                child: ValueListenableBuilder(
                    valueListenable: Hive.box<Subject>(HiveBoxesSubject.subject)
                        .listenable(),
                    builder: (context, Box<Subject> box, _) {
                      if (box.values.isEmpty) {
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.only(top: 120),
                              child: const Text("Subject list is empty")),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: box.values.length,
                            itemBuilder: (context, index) {
                              int reverseIndex = box.length - 1 - index;
                              final Subject? res = box.getAt(reverseIndex);
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
                                                          ' ' +
                                                          res.subjectUnit
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
                                                  onPressed: () {},
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
                                                const SizedBox(width: 20),
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
