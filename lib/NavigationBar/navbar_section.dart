import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smapp/NavigationBar/src/app_title.dart';
import 'package:smapp/NavigationBar/src/navbar_states.dart';
import 'package:smapp/NavigationBar/src/navbar_item.dart';

class Navibar extends StatelessWidget {
  const Navibar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100.0,
        color: Color(0xff333951),
        child: Stack(
          children: [
            CompanyName(),
            Align(
              alignment: Alignment.center,
              child: NavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
