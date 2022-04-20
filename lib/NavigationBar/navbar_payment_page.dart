import 'package:flutter/material.dart';
import 'package:smapp/NavigationBar/navbar_faculty_states.dart';
import 'package:smapp/NavigationBar/navbar_payment_states.dart';
import 'package:smapp/NavigationBar/navbar_student_states.dart';
import 'package:smapp/NavigationBar/src/app_title.dart';

class NavibarPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100.0,
        color: Colors.orange,
        child: Stack(
          children: [
            CompanyName(),
            Align(
              alignment: Alignment.center,
              child: NavBarPayment(),
            ),
          ],
        ),
      ),
    );
  }
}
