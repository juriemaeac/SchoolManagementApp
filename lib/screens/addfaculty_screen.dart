import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addfaculty_information.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/models/faculty_model.dart';

class AddFacultyScreen extends StatefulWidget {
  const AddFacultyScreen({Key? key}) : super(key: key);

  @override
  _AddFacultyScreen createState() => _AddFacultyScreen();
}

class _AddFacultyScreen extends State<AddFacultyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String username = '';
  late String password = '';
  late String firstName = '';
  late String middleName = '';
  late String lastName = '';
  late String userFaculty = '';
  late bool isAdmin = false;

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                              margin:
                                  const EdgeInsets.only(bottom: 20, left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'Add Faculty',
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              //height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10, left: 10),
                              margin: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Username',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          username = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      autofocus: true,
                                      initialValue: '',
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      autofocus: true,
                                      initialValue: '',
                                      decoration: const InputDecoration(
                                        labelText: 'Faculty First Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          firstName = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      initialValue: '',
                                      decoration: const InputDecoration(
                                        labelText: 'Middle Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          middleName = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      initialValue: '',
                                      decoration: const InputDecoration(
                                        labelText: 'Last Name',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          lastName = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                      initialValue: '',
                                      decoration: const InputDecoration(
                                        labelText: 'Faculty Department',
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 2),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          userFaculty = value;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 5,
                                        bottom: 5),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: const Text("Admin"),
                                          leading: Radio<bool>(
                                            value: false,
                                            groupValue: isAdmin,
                                            onChanged: (value) {
                                              setState(() {
                                                isAdmin = value ?? false;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text("Not Admin"),
                                          leading: Radio<bool>(
                                            value: true,
                                            groupValue: isAdmin,
                                            onChanged: (value) {
                                              setState(() {
                                                isAdmin = value ?? true;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10.0),
                                                      side: const BorderSide(
                                                          color: Colors
                                                              .orange)))),
                                          onPressed: () {
                                            validated();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Add Faculty',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10.0),
                                                      side: const BorderSide(
                                                          color: Colors
                                                              .orange)))),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const NavibarFaculty(),
                const AddFacultyInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    // late String username = '';
    // late String password = '';
    // late String firstName = '';
    // late String middleName = '';
    // late String lastName = '';
    // late String userFaculty = '';
    // late bool isAdmin = false;
    Box<Faculty> facultyBox = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    facultyBox.add(Faculty(
        username: username,
        password: password,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        userFaculty: userFaculty,
        isAdmin: isAdmin));
    Navigator.of(context).pop();
  }
}
