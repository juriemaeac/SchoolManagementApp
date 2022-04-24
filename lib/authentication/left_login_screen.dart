import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPageRightSide extends StatelessWidget {
  const LoginPageRightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.orange,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg1.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            height: 550,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 12, sigmaX: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(42),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              width: 120,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "National \nPolytechnic College \nScience and Technology",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.00,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 0, right: 10.0, left: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Flexible(
                          child: Text(
                            "COMPETITIVE KNOWLEDGE, SKILLS AND ATTITUDES IN A HIGHLY TECHNOLOGICALLY-ORIENTED SOCIETY",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/design.png',
                          width: 350,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 30, top: 100),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 9,
                          // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 30, top: 300),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 9,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.folder,
                    color: Colors.orange,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
