import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/CalendarSpace/src/calendar_item.dart';
import 'package:intl/intl.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateNow = DateFormat("MMMM yyyy").format(DateTime.now());
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateNow,
                style: GoogleFonts.quicksand(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 25.0, top: 15.0, right: 25.0, bottom: 0),
          child: Row(
            children: const [
              CalendarWeekly(),
            ],
          ),
        ),
      ],
    );
  }
}
