import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smapp/authentication/right_login_screen.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String user = facultyCredential.getString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [          
          Row(
            children: const [
              Icon(
                Feather.user,
                color: Colors.black,
                size: 20.0,
                
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
         Text(
                'Hello $user.',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
        ],
      ),
    );
  }
}
