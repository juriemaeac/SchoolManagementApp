import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/models/student_model.dart';

class AddFacultyScreen extends StatefulWidget {
  AddFacultyScreen({Key? key}) : super(key: key);

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
      print("Form Validated");
    } else {
      print("Form Not Validated");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Faculty'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Faculty Username'),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'Faculty Password'),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  initialValue: '',
                  decoration: InputDecoration(labelText: 'Faculty First Name'),
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Faculty Middle Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      middleName = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Faculty Last Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    labelText: 'Faculty Department',
                  ),
                  onChanged: (value) {
                    setState(() {
                      userFaculty = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "required";
                    }
                    return null;
                  },
                ),                            
                Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Admin"),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value??false;
                          print(value);
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  ListTile(
                    title: Text("Not Admin"),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value??true;
                          print(value);
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ],
                ),               
                ElevatedButton(
                  onPressed: () {
                    validated();
                  },
                  child: Text('Add Faculty'),
                )
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
    print(facultyBox);
  }
}
