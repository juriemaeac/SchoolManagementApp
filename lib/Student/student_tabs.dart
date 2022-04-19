import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          Text(
            'With',
            style: GoogleFonts.quicksand(
              fontSize: 12.0,
            ),
          ),
          const SizedBox(
            width: 7.0,
          ),
          Container(
            height: 25.0,
            width: 75.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                'Real-time',
                style: GoogleFonts.quicksand(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 7.0,
          ),
          Text(
            'Database',
            style: GoogleFonts.quicksand(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
