import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smapp/NavigationBar/src/navbar_item.dart';
import 'package:smapp/screens/editfaculty_screen.dart';
import 'package:smapp/screens/payment_transaction_screen.dart';
import 'package:smapp/screens/students_screen.dart';
import 'package:smapp/splash_screen.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import 'package:smapp/dashboard_page.dart';
import 'package:smapp/student_page.dart';

class NavBar extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Start(),
                ),
              );
            },
          ),
          NavBarItem(
            icon: Feather.list,
            active: selected[1],
            touched: () {
              setState(() {
                select(1);
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentPage(),
                ),
              );
            },
          ),
          NavBarItem(
            icon: Feather.folder,
            active: selected[2],
            touched: () {
              setState(() {
                select(2);
              });
            },
          ),
          NavBarItem(
            icon: Feather.message_square,
            active: selected[3],
            touched: () {
              setState(() {
                select(3);
              });
            },
          ),
          NavBarItem(
            icon: Feather.settings,
            active: selected[4],
            touched: () {
              setState(() {
                select(4);
              });
            },
          ),
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
