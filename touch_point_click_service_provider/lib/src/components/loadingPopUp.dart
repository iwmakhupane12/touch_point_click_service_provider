import 'dart:math' as math;

import 'package:flutter/material.dart';

class LoadingPopUp extends StatefulWidget {
  final Color loadingColor;

  LoadingPopUp({@required this.loadingColor});

  @override
  _LoadingPopUpState createState() => _LoadingPopUpState();
}

class _LoadingPopUpState extends State<LoadingPopUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ProgressPainter(controller, widget.loadingColor),
              );
            }));
  }
}

class ProgressPainter extends CustomPainter {
  double startAngle, sweepAngle;
  double pi = math.pi;
  Color loadingColor;

  final AnimationController controller;
  ProgressPainter(this.controller, this.loadingColor) {
    startAngle = Tween(begin: pi * 1.5, end: pi * 3.5)
        .chain(CurveTween(curve: Interval(0.5, 1.0)))
        .evaluate(controller);
    sweepAngle = math.sin(controller.value * pi) * pi;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = loadingColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Offset.zero & Size(side, side),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressPainter other) {
    return startAngle != other.startAngle || sweepAngle != other.sweepAngle;
  }
}
