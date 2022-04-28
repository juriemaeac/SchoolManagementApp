import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/CalendarSpace/addfaculty_information.dart';
import 'package:smapp/NavigationBar/navbar_faculty_page.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/models/faculty_model.dart';

import '../../faculty_page.dart';

class EditFacultyScreen extends StatefulWidget {
  final Faculty faculty;
  final int index;
  const EditFacultyScreen(
      {Key? key, required this.faculty, required this.index})
      : super(key: key);

  @override
  _EditFacultyScreen createState() => _EditFacultyScreen();
}

class _EditFacultyScreen extends State<EditFacultyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int facultyIndex = widget.index;
  String? username;
  String? password;
  String? firstName;
  String? middleName;
  String? lastName;
  String? userFaculty;
  bool? isAdmin;

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    username = widget.faculty.username;
    password = widget.faculty.password;
    firstName = widget.faculty.firstName;
    middleName = widget.faculty.middleName;
    lastName = widget.faculty.lastName;
    userFaculty = widget.faculty.userFaculty;
    isAdmin = widget.faculty.isAdmin;

    String oldUsername = widget.faculty.username;

    TextEditingController _usernameController = TextEditingController()
      ..text = widget.faculty.username;
    TextEditingController _passwordController = TextEditingController()
      ..text = widget.faculty.password;
    TextEditingController _firstNameController = TextEditingController()
      ..text = widget.faculty.firstName;
    TextEditingController _middleNameController = TextEditingController()
      ..text = widget.faculty.middleName;
    TextEditingController _lastNameController = TextEditingController()
      ..text = widget.faculty.lastName;
    TextEditingController _userFacultyController = TextEditingController()
      ..text = widget.faculty.userFaculty;

    @override
    void initState() {
      super.initState();
      _usernameController.addListener(() {
        setState(() {
          username = _usernameController.text;
        });
      });
      _passwordController.addListener(() {
        setState(() {
          password = _passwordController.text;
        });
      });
      _firstNameController.addListener(() {
        setState(() {
          firstName = _firstNameController.text;
        });
      });
      _middleNameController.addListener(() {
        setState(() {
          middleName = _middleNameController.text;
        });
      });
      _lastNameController.addListener(() {
        setState(() {
          lastName = _lastNameController.text;
        });
      });
      _userFacultyController.addListener(() {
        setState(() {
          userFaculty = _userFacultyController.text;
        });
      });
    }

    @override
    void dispose() {
      _usernameController.dispose();
      _passwordController.dispose();
      _firstNameController.dispose();
      _middleNameController.dispose();
      _lastNameController.dispose();
      _userFacultyController.dispose();
      super.dispose();
    }

    List<String> departments = ['Cashier', 'Registrar', 'Professor'];

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
                              height: MediaQuery.of(context).size.height * 0.04,
                              margin:
                                  const EdgeInsets.only(bottom: 20, left: 20),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'Edit Faculty',
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      //enabled: false,
                                      autofocus: true,
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Faculty Username',
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
                                        //setState(() {
                                        username =
                                            _usernameController.value.text;
                                        //});
                                      },
                                      validator: (String? value) {
                                        Box<Faculty> facultyBox =
                                            Hive.box<Faculty>(
                                                HiveBoxesFaculty.faculty);
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required";
                                        }
                                        if (value != oldUsername) {
                                          for (var faculty in facultyBox.values) {
                                          if (faculty.username == value) {
                                            return "Username already exists";
                                          }
                                        }
                                        }
                                        
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        labelText: 'Faculty Password',
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
                                        //setState(() {
                                        password =
                                            _passwordController.value.text;
                                        //});
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      controller: _firstNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'First Name',
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
                                        //setState(() {
                                        firstName =
                                            _firstNameController.value.text;
                                        //});
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      controller: _middleNameController,
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
                                        //setState(() {
                                        middleName = value;
                                        //});
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      controller: _lastNameController,
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
                                        //setState(() {
                                        lastName = value;
                                        //});
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
                                        left: 15, right: 15, top: 5, bottom: 5),
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
                                      controller: _userFacultyController,
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
                                        //setState(() {
                                        userFaculty = value;
                                        //});
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().length == 0) {
                                          return "required";
                                        }
                                        if (departments.contains(value) !=
                                            true) {
                                          return "Department not found. [Cashier, Registrar, Professor]";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
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
                                                  'Save Faculty',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
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
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: const BorderSide(
                                                          color:
                                                              Colors.orange)))),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const FacultyPage(),
                                              ),
                                            );
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
                                                    fontWeight: FontWeight.w400,
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
    Box<Faculty> facultyBox = Hive.box<Faculty>(HiveBoxesFaculty.faculty);

    facultyBox.putAt(
        facultyIndex,
        Faculty(
          username: username ?? '',
          password: password ?? '',
          firstName: firstName ?? '',
          middleName: middleName ?? '',
          lastName: lastName ?? '',
          userFaculty: userFaculty ?? '',
          isAdmin: isAdmin ?? false,
        ));
    Navigator.of(context).pop();
  }
}
