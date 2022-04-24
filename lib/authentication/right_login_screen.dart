import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/dashboard_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              builder: (context) => const DashboardPage(),
            ));
      } else if (username != adminUsername && password != adminPassword) {
        // add username and password in global list
        facultyBox.values.forEach((faculty) {
          if (faculty.username == username && faculty.password == password) {
            facultyCredential.setString(username);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ));
          } else if (faculty.username != username &&
              faculty.password != password) {
            errorMessage = 'Wrong Credentials. Please try again.';
            clearInputFields();
          }
        });
      }
    } else {
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
                    "Enrollment \nand Billing System",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Let's build a better future with NPCSTians!",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.orange),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 9,
                          offset: const Offset(2, 6),
                          // changes position of shadow
                        ),
                      ],
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
                              BorderSide(color: Colors.transparent, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().length == 0) {
                          return "Required!";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 9,
                          offset: const Offset(2, 6),
                          // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                          ),
                          labelText: 'Enter Password',
                          suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
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
                          return "Required!";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      errorMessage ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 14),
                  MaterialButton(
                    onPressed: () {
                      validated();
                      setState(() {});
                    },
                    child: const Text("Login"),
                    minWidth: double.infinity,
                    height: 52,
                    elevation: 24,
                    color: Colors.amber.shade700,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Don't have an account? Contact your Administrator.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
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
