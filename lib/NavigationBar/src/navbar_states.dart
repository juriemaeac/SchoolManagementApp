import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:smapp/NavigationBar/src/navbar_item.dart';
import 'package:smapp/boxes/boxFaculty.dart';
import 'package:smapp/boxes/boxStudent.dart';
import 'package:smapp/faculty_page.dart';
import 'package:smapp/maintenance_page.dart';
import 'package:smapp/models/faculty_model.dart';
import 'package:smapp/models/student_model.dart';
import 'package:smapp/payment_transaction_page.dart';
import 'package:smapp/splash_screen.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/student_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [true, false, false, false, false];
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  bool? isAdmin = false;
  bool? isUserRegistrar = false;
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    var user = facultyCredential.getString();
    if (user == 'admin') {
      isAdmin = true;
    }
    isUserRegistrar = isRegistrar();
  }

  isRegistrar() {
    final box = Hive.box<Faculty>(HiveBoxesFaculty.faculty);
    String username = facultyCredential.getString();
    bool visible = false;
    if (username == 'admin') {
      visible = true;
      return visible;
    }
    for (final faculty in box.values) {
      if (faculty.username == username) {
        if (faculty.userFaculty == 'Registrar') {
          visible = true;
          return visible;
        } else {
          visible = false;
          return visible;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.0,
      child: Column(
        children: [
          NavBarItem(
            icon: Feather.home,
            active: selected[0],
            touched: () {
              setState(() {
                select(0);
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DashboardPage(),
              //   ),
              // );
            },
          ),
          NavBarItem(
            icon: Feather.users,
            active: selected[1],
            touched: () {
              setState(() {
                select(1);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentPage(),
                ),
              );
            },
          ),
          Visibility(
            visible: isAdmin ?? false,
            child: NavBarItem(
              icon: Feather.briefcase,
              active: selected[2],
              touched: () {
                setState(() {
                  select(2);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FacultyPage(),
                  ),
                );
              },
            ),
          ),
          NavBarItem(
            icon: Feather.paperclip,
            active: selected[3],
            touched: () {
              setState(() {
                select(3);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentPage(),
                ),
              );
            },
          ),
          Visibility(
            visible: isUserRegistrar ?? false,
            child: NavBarItem(
              icon: Feather.archive,
              active: selected[4],
              touched: () {
                setState(() {
                  select(4);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaintenancePage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          NavBarItem(
            icon: Feather.log_out,
            active: false,
            touched: () {
              facultyCredential.setString('');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
