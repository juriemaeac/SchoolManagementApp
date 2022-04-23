import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          Text(
            'All',
            style: GoogleFonts.quicksand(
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Container(
            height: 25.0,
            width: 90.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                'Information',
                style: GoogleFonts.quicksand(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'At',
            style: GoogleFonts.quicksand(
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'Glance',
            style: GoogleFonts.quicksand(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
