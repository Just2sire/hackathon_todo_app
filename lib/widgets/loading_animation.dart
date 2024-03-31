import 'package:flutter/material.dart';

class LoadingCircle extends StatefulWidget {
  final double percent;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final double size;
  final Widget? content;
  const LoadingCircle({
    super.key,
    required this.percent,
    required this.progressColor,
    required this.size,
    required this.backgroundColor,
    this.strokeWidth = 10,
    this.content = const Text(
      "0%",
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  });

  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> loadAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    loadAnimation = Tween<double>(
      begin: 0,
      end: widget.percent,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // AnimatedBuilder fonctionne un peu comme TweenAnimationBuilder et il nous permet d'avoir la valeur
      // courante de notre animation permettant ainsi de build le widget en fonction de ça
      // Ici, on utilise loadAnimation.value
      child: AnimatedBuilder(
        animation: loadAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  value: loadAnimation.value,
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: widget.backgroundColor,
                  color: widget.progressColor,
                ),
              ),
              widget.content ?? const SizedBox(),
              // Text(
              //   '${(loadAnimation.value * 100).toInt()}%',
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
