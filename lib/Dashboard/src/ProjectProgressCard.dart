import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectProgressCard extends StatefulWidget {
  final Color color;
  final Color progressIndicatorColor;
  final String projectName;
  final IconData icon;
  final int count;
  ProjectProgressCard({
    required this.color,
    required this.progressIndicatorColor,
    required this.projectName,
    required this.icon,
    required this.count,
  });
  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (value) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 275),
        height: hovered ? 145.0 : 135.0,
        width: hovered ? 230.0 : 210.0,
        decoration: BoxDecoration(
            color: hovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                spreadRadius: 5.0,
              ),
            ]),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 18.0,
                  ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(
                      widget.icon,
                      color: !hovered ? Colors.white : Colors.black,
                      size: 16.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: hovered ? Colors.white : widget.color,
                    ),
                  ),
                  const SizedBox(
                    width: 13.0,
                  ),
                  Text(
                    widget.projectName,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: hovered ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  crossAxisAlignment: hovered
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: hovered
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.0,
                      width: 13.0,
                      child: Icon(
                        Feather.box,
                        size: hovered ? 18 : 13.0,
                        color: hovered ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        '${widget.count} records',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          fontSize: hovered ? 20.0 : 13.0,
                          color: hovered ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 275),
                margin: const EdgeInsets.only(top: 5.0),
                height: 6.0,
                width: hovered ? 190 : 160,
                decoration: BoxDecoration(
                  color: hovered
                      ? widget.progressIndicatorColor
                      : const Color(0xffF5F6FA),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 275),
                    height: 6.0,
                    width: hovered ? 190 : 160,
                    decoration: BoxDecoration(
                      color: hovered ? Colors.white : widget.color,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
