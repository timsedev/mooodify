import 'dart:developer' as logger;
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedOrbit extends StatefulWidget {
  const AnimatedOrbit({super.key});

  @override
  State<AnimatedOrbit> createState() => _AnimatedOrbitState();
}

class _AnimatedOrbitState extends State<AnimatedOrbit>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late AnimationController colorController;
  late Animation colorAnimation;
  late Animation positionAnimation;
  late Animation shadowAnimation;
  late Animation shadowColorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() => setState(() {}));

    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    colorController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);

    colorAnimation = ColorTween(begin: Colors.lightGreen, end: Colors.yellow)
        .animate(colorController);

    positionAnimation = Tween(begin: 5.0, end: 12.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    shadowAnimation = Tween(begin: 5.0, end: 8.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    shadowColorAnimation = ColorTween(
            begin: Colors.grey[900]!.withOpacity(0.5),
            end: Colors.grey[400]!.withOpacity(0.3))
        .animate(controller);

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    colorController.dispose();
    controller.dispose();
    rotationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            AnimatedBuilder(
              animation: rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotationController.value * 2.0 * pi,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.lightGreen,
                          colorAnimation.value,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Center(
                  child: Text(
                'Happy',

                /// temporarily happy ;)
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.white10,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
        SizedBox(height: shadowAnimation.value * 2),
        ClipOval(
          child: Container(
            width: shadowAnimation.value * 9,
            height: shadowAnimation.value * 1,
            color: shadowColorAnimation.value,
          ),
        ),
      ],
    );
  }
}
