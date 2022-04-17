import 'package:flutter/material.dart';
import 'package:smapp/NavigationBar/navbar_section.dart';
import 'package:smapp/CalendarSpace/information_section.dart';
import 'package:smapp/Dashboard/dashboard_section.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            const Navibar(),
            DashBoard(),
            CalendarSpace(),
          ],
        ),
      ),
    );
  }
}
