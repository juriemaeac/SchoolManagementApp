import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:smapp/Dashboard/src/ProjectProgressCard.dart';
import 'package:smapp/Dashboard/src/SharedFilesItem.dart';
import 'package:smapp/Dashboard/src/SubHeader.dart';
import 'package:smapp/Dashboard/src/Tabs.dart';
import 'package:smapp/authentication/right_login_screen.dart';
import '../boxes/boxFaculty.dart';
import '../boxes/boxPayment.dart';
import '../boxes/boxStudent.dart';
import '../models/faculty_model.dart';
import '../models/payment_model.dart';
import '../models/student_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Student>(HiveBoxesStudent.student);
    Hive.openBox<Faculty>(HiveBoxesFaculty.faculty);
    Hive.openBox<Payment>(HiveBoxesPayment.payment);
    var user = facultyCredential.getString();
    if (user == '') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var studentCount = Hive.box<Student>(HiveBoxesStudent.student).length;
    var facultyCount = Hive.box<Faculty>(HiveBoxesFaculty.faculty).length;
    var paymentCount = Hive.box<Payment>(HiveBoxesPayment.payment).length;
    return Positioned(
      left: 100.0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.63,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 30.0, top: 25.0, bottom: 10.0),
              child: Text(
                'Dashboard',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Tabs(),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              height: 200.0,
              width: MediaQuery.of(context).size.width * 0.62,
              child: Column(
                children: [
                  SubHeader(
                    title: 'Real-time Analytics',
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProjectProgressCard(
                        color: const Color(0xffFF4C60),
                        projectName: 'Students Enrolled',
                        progressIndicatorColor: Colors.redAccent[100]!,
                        icon: Feather.users,
                        count: studentCount,
                      ),
                      ProjectProgressCard(
                        color: const Color(0xff6C6CE5),
                        projectName: 'Users Enlisted',
                        progressIndicatorColor: Colors.blue[200]!,
                        icon: Feather.briefcase,
                        count: facultyCount,
                      ),
                      ProjectProgressCard(
                        color: const Color(0xffFAAA1E),
                        projectName: 'Payments Recorded',
                        progressIndicatorColor: Colors.amber[200]!,
                        icon: Feather.paperclip,
                        count: paymentCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SubHeader(
              title: 'University Profile',
            ),
            SharedFilesItem(
              color: Colors.red,
              sharedFileName: 'Classification',
              first: 'Private College',
              second: 'Bi-Semestral',
              third: 'Est. 2000',
              icon: Icons.account_balance,
            ),
            SharedFilesItem(
              color: Colors.amber,
              sharedFileName: 'Courses Offered',
              first: "4 Bachelor Programs",
              second: '7 Certificate Programs',
              third: '11 crs.',
              icon: Feather.clipboard,
            ),

            SubHeader(
              title: 'University Information',
            ),
            SharedFilesItem(
              color: Colors.purple,
              sharedFileName: 'Location',
              first: '892 Quirino Hwy,',
              second: 'Novaliches, Quezon City',
              third: 'Metro Manila',
              icon: Feather.map_pin,
            ),
            SharedFilesItem(
              color: Colors.blue,
              sharedFileName: 'Web Page',
              first: "@NPCSTians",
              second: 'https://www.facebook.com/NPCSTians/',
              third: 'Facebook',
              icon: Feather.facebook,
            ),
            SharedFilesItem(
              color: Colors.green,
              sharedFileName: 'Contacts',
              first: "+63 8967-6663",
              second: 'nationalpolytechnic2000@gmail.com',
              third: 'Metro Manila',
              icon: Feather.phone,
            ),
            //ProjectStatisticsCards(),
          ],
        ),
      ),
    );
  }
}
