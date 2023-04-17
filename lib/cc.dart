import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCircles extends StatefulWidget {
  @override
  _AnimatedCirclesState createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<AnimatedCircles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _CirclesPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _CirclesPainter extends CustomPainter {
  final double animationValue;

  _CirclesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Draw 10 circles with varying sizes and positions
    for (int i = 0; i < 20; i++) {
      double circleSize =
          20.0 * (1 + math.sin(animationValue * math.pi * 2 + i));

      double xPos =
          size.width / 2 + 50 * math.cos(animationValue * math.pi * 2 + i);
      double yPos =
          size.height / 2 + 50 * math.sin(animationValue * math.pi * 2 + i);

      canvas.drawCircle(Offset(xPos, yPos), circleSize, paint);
    }
  }

  @override
  bool shouldRepaint(_CirclesPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
