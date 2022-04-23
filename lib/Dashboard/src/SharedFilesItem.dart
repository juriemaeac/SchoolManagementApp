import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedFilesItem extends StatefulWidget {
  final String sharedFileName;
  final Color color;
  final String first;
  final String second;
  final String third;
  final IconData icon;

  SharedFilesItem({
    required this.color,
    required this.second,
    required this.third,
    required this.first,
    required this.sharedFileName,
    required this.icon,
  });

  @override
  _SharedFilesItemState createState() => _SharedFilesItemState();
}

class _SharedFilesItemState extends State<SharedFilesItem> {
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
        duration: Duration(milliseconds: 275),
        margin: EdgeInsets.only(bottom: 10.0, left: 40.0, right: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: hovered
                ? [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 13.0,
                      spreadRadius: 0.0,
                    ),
                  ]
                : []),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.63,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Container(
                          height: 28.0,
                          width: 28.0,
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              color: widget.color,
                              size: 15.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          widget.sharedFileName,
                          style: GoogleFonts.quicksand(
                            color: hovered? widget.color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text(
                                  widget.first,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 235,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  widget.second,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Text(
                                  widget.third,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
