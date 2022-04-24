import 'package:flutter/material.dart';
import 'package:smapp/NavigationBar/navbar_faculty_states.dart';
import 'package:smapp/NavigationBar/src/app_title.dart';

class NavibarFaculty extends StatelessWidget {
  const NavibarFaculty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100.0,
        color: Colors.orange,
        child: Stack(
          children: const [
            CompanyName(),
            Align(
              alignment: Alignment.center,
              child: NavBarFaculty(),
            ),
          ],
        ),
      ),
    );
  }
}
