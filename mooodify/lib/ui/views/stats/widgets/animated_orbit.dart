import 'package:flutter/material.dart';
import 'package:mooodify/ui/common/contants.dart';

class AnimatedOrbit extends StatefulWidget {
  const AnimatedOrbit({super.key});

  @override
  State<AnimatedOrbit> createState() => _AnimatedOrbitState();
}

class _AnimatedOrbitState extends State<AnimatedOrbit>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController shadowController;
  late Animation colorAnimation;
  late Animation positionAnimation;
  late Animation shadowAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() => setState(() {}));
    shadowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() => setState(() {}));

    colorAnimation =
        ColorTween(begin: Colors.red[900], end: Colors.lightGreenAccent[700])
            .animate(controller);

    positionAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    shadowAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: shadowController,
        curve: Curves.easeInOut,
      ),
    );

    controller.repeat(reverse: true);
    shadowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    shadowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(bottom: positionAnimation.value),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorAnimation.value,
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
