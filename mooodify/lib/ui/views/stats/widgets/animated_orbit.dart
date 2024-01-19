import 'package:flutter/material.dart';

class AnimatedOrbit extends StatefulWidget {
  const AnimatedOrbit({super.key});

  @override
  State<AnimatedOrbit> createState() => _AnimatedOrbitState();
}

class _AnimatedOrbitState extends State<AnimatedOrbit> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ,
      builder: (context, child) {
        return Container(
          // This is your orbit. Adjust as needed.
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ,
          ),
        );
      },
      // child: Container(
      //   width: 300,
      //   height: 300,
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     gradient: RadialGradient(
      //       colors: viewModel.gradientColors,
      //       center: Alignment.center,
      //       radius: 0.8,
      //     ),
      //   ),
      //   child: ClipOval(
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //       child: Container(
      //         color: Colors.transparent,
      //         child: Center(
      //           child: Text(
      //             viewModel.currentAverage.toStringAsFixed(1),
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 25,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
