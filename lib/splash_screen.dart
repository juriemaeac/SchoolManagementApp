import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smapp/left_login_screen.dart';
import 'package:smapp/right_login_screen.dart';
import 'package:smapp/screens/students_screen.dart';

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
      backgroundColor: Colors.orange,
      
      body: Stack(
        
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: copAnimated ? screenWidth/2 : screenWidth,
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
                    height: MediaQuery.of(context).size.height/2,
                    controller: _coffeeController,
                    onLoaded: (composition) {
                      _coffeeController
                        ..duration = composition.duration
                        ..forward();
                    },
                    
                  ),
                ),
                // Visibility(
                //   visible: copAnimated,
                //   child: Image.asset(
                //     'assets/education.png',
                //     height: 150.0,
                //     width: 150.0,
                //   ),
                // ),
                // Center(
                //   child: AnimatedOpacity(
                //     opacity: animateCafeText ? 1 : 0,
                //     duration: const Duration(seconds: 1),
                //     child: const Text(
                //       'S M A P P',
                //       style: TextStyle(fontSize: 50.0, color: Colors.black),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: copAnimated, child: Row(
              children: [
                LoginScreen(),
                if (MediaQuery.of(context).size.width > 900)
                  const LoginPageRightSide(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// class _BottomPart extends StatelessWidget {
//   const _BottomPart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
      
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Text(
//               'Find The Best Coffee for You',
//               style: TextStyle(
//                   fontSize: 27.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             const SizedBox(height: 30.0),
//             Text(
//               'Lorem ipsum dolor sit amet, adipiscing elit. '
//               'Nullam pulvinar dolor sed enim eleifend efficitur.',
//               style: TextStyle(
//                 fontSize: 15.0,
//                 color: Colors.white.withOpacity(0.8),
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 50.0),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 85.0,
//                 width: 85.0,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2.0),
//                 ),
//                 child: const Icon(
//                   Icons.chevron_right,
//                   size: 50.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50.0),
//           ],
//         ),
//       ),
//     );
//   }
// }