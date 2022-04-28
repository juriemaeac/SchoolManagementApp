import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/CalendarSpace/addstudent_information.dart';
import 'package:smapp/NavigationBar/navbar_student_page.dart';
import 'package:smapp/screens/addstudent_screen.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  margin: const EdgeInsets.only(left: 130, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.63,
                  child: Text(
                    'Add Student',
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
                    height: MediaQuery.of(context).size.height - 100,
                    margin: const EdgeInsets.only(left: 70),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const AddStudentScreen()),
              ],
            ),
            const NavibarStudent(),
            const AddStudentInfo(),
          ],
        ),
      ),
    );
  }
}
