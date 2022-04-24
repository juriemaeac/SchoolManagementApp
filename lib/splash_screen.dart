import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smapp/authentication/left_login_screen.dart';
import 'package:smapp/authentication/right_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Visibility(
            visible: copAnimated,
            child: Row(
              children: [
                const LoginScreen(), //ung nasa left, lalabas kapag maliit
                if (MediaQuery.of(context).size.width > 900)
                  const LoginScreen(), //login mismo
              ],
            ),
          ),
          // White Container top half
          if (MediaQuery.of(context).size.width > 900)
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: copAnimated ? screenWidth / 2 : screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(copAnimated ? 0.0 : 0.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: !copAnimated,
                    child: Lottie.asset(
                      'assets/book.json',
                      height: MediaQuery.of(context).size.height / 2,
                      controller: _coffeeController,
                      onLoaded: (composition) {
                        _coffeeController
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                  Visibility(
                    visible: copAnimated,
                    child: const LoginPageRightSide(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
