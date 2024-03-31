import 'package:flutter/material.dart';
import 'package:todo_app/configs/utils.dart';
import 'package:todo_app/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animeController;

  @override
  void initState() {
    super.initState();

    const animeDuration = Duration(milliseconds: 1000);
    animeController = AnimationController(
      vsync: this,
      duration: animeDuration,
    );

    animeController.forward();
    animeController.repeat(
      reverse: true,
      min: 0.7,
    );

    Future.delayed(const Duration(seconds: 3), () {
      context.navToAndReplace(const HomeScreen());
    });
  }

  @override
  void dispose() {
    animeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF6F6F6),
      ),
      child: AnimatedBuilder(
        animation: animeController,
        builder: (context, child) {
          return Transform.scale(
            scale: animeController.value * 1.2,
            child: child,
          );
        },
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFF9581FF),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check,
                size: context.width * 0.4,
                color: const Color(0xFF9581FF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
