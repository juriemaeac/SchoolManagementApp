import 'package:flutter/material.dart';
import 'package:smapp/NavigationBar/navbar_section.dart';
import 'package:smapp/CalendarSpace/information_section.dart';
import 'package:smapp/Dashboard/dashboard_section.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: const [
            Navibar(),
            DashBoard(),
            CalendarSpace(),
          ],
        ),
      ),
    );
  }
}
