import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/models/student_model.dart';
import 'package:smapp/screens/students_screen.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/dashboard_page.dart';
import '../screens/faculty_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? adminUsername = "admin";
  String? adminPassword = "password";
  late String username;
  late String password;
  final usernameText = TextEditingController();
  final passwordText = TextEditingController();
  String? errorMessage = '';

  validated() {
    Box<Faculty> facultyBox = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (username == adminUsername && password == adminPassword) {
        facultyCredential.setString(username);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Start(),
            ));
      } else if (username != adminUsername && password != adminPassword) {
        // add username and password in global list
        facultyBox.values.forEach((faculty) {
          if (faculty.username == username && faculty.password == password) {
            facultyCredential.setString(username);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentScreen(title: 'Student List'),
                ));
          } else if (faculty.username != username &&
              faculty.password != password) {
            errorMessage = 'Wrong Credentials. Please try again.';
            clearInputFields();
          }
        });
        print('Wrong Credentials');
      }
    } else {
      print("Form Not Validated");
      return;
    }
  }

  void clearInputFields() {
    usernameText.clear();
    passwordText.clear();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(120.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "The safest app on the web for storing your data!",
                    style: TextStyle(fontSize: 12),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f5f9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      controller: usernameText,
                      decoration: const InputDecoration(
                        labelText: 'Enter Username',
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2),
                        ),
                      ),
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
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f5f9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.orange, width: 2),
                          ),
                          labelText: 'Enter Password',
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                      autofocus: true,
                      controller: passwordText,
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
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      errorMessage ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 24),
                  MaterialButton(
                    onPressed: () {
                      validated();
                      setState(() {});
                    },
                    child: Text("Login"),
                    minWidth: double.infinity,
                    height: 52,
                    elevation: 24,
                    color: Colors.amber.shade700,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class facultyCredential {
  static String username = "";
  static void setString(String newValue) {
    username = newValue;
  }

  static String getString() {
    return username;
  }
}
