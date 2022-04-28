import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smapp/faculty_page.dart';
import 'package:smapp/screens/editfaculty_screen.dart';
import '../models/faculty_model.dart';

class FacultyScreen extends StatefulWidget {
  final String title;
  const FacultyScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
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
                          'Users List',
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
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              height: 30,
                              width: 220,
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
                                controller: facultyController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 11),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: '    Search by Username',
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(3),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                              color: Colors.orange)))),
                              onPressed: () {
                                String usernameVal = facultyController.text;
                                validator(usernameVal);
                                setState(() {
                                  searchUsername = facultyController.text;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            const SizedBox(width: 10),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff6C6CE5),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: const Icon(Icons.refresh_rounded,
                                            color: Colors.white, size: 15)),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const FacultyPage(),
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
          const SizedBox(height: 15),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<Faculty>(HiveBoxesFaculty.faculty).listenable(),
              builder: (context, Box<Faculty> box, _) {
                if (box.values.isEmpty) {
                  return Center(
                    child: Container(
                        padding: const EdgeInsets.only(top: 120),
                        child: const Text("Users list is empty")),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: isSearching ? 1 : box.values.length,
                      itemBuilder: (context, index) {
                        int reverseIndex = box.length - 1 - index;
                        final Faculty? res = isSearching
                            ? box.values
                                .where((faculty) =>
                                    faculty.username == searchUsername)
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //alignment: WrapAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
        ],
      ),
    );
  }
}
