import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/screens/editfaculty_screen.dart';
import '../models/faculty_model.dart';

class FacultyScreen extends StatefulWidget {
  final String title;
  const FacultyScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
          valueListenable:
              Hive.box<Faculty>(HiveBoxesFaculty.faculty).listenable(),
          builder: (context, Box<Faculty> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Faculty list is empty"),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Faculty? res = box.getAt(index);
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //alignment: WrapAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        res!.lastName +
                                            ', ' +
                                            res.firstName +
                                            ' ' +
                                            res.middleName,
                                        style: GoogleFonts.quicksand(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Text(
                                    res.userFaculty.toString(),
                                    style: GoogleFonts.quicksand(
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                            255, 102, 101, 101)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.all(3.0),
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    icon: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: SvgPicture.asset(
                                        'assets/edit_svg.svg',
                                      ),
                                    ),
                                    onPressed: () {
                                      Faculty faculty = Faculty(
                                        username: res.username,
                                        password: res.password,
                                        firstName: res.firstName,
                                        middleName: res.middleName,
                                        lastName: res.lastName,
                                        userFaculty: res.userFaculty,
                                        isAdmin: res.isAdmin,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditFacultyScreen(
                                            faculty: faculty,
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
            );
          }),
    );
  }
}
