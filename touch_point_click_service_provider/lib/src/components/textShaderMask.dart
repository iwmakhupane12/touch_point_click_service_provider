import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class TextShaderMask extends StatefulWidget {
  final String btnText;
  final bool dismissed;

  TextShaderMask({@required this.btnText, @required this.dismissed});

  @override
  _TextShaderMaskState createState() => _TextShaderMaskState();
}

class _TextShaderMaskState extends State<TextShaderMask>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  String _text;
  bool _dismissed;

  @override
  void initState() {
    super.initState();
    _text = widget.btnText;
    _dismissed = widget.dismissed;
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              colors: [Colors.grey, Colors.white, Colors.grey],
              stops: [
                controller.value - 0.3,
                controller.value,
                controller.value + 0.3
              ],
            ).createShader(
              Rect.fromLTWH(0, 0, rect.width, rect.height),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btnForwardArrows(),
              Text(
                _text,
                style: AppTextStyles.normalBlack(
                  FontWeight.normal,
                  Colors.white,
                ),
              ),
              btnBackwardArrows()
            ],
          ),
          blendMode: BlendMode.srcIn,
        );
      },
    );
  }

  Widget btnForwardArrows() {
    Icon displayIcon = Icon(
      Icons.arrow_forward_ios_rounded,
      color: Colors.white,
    );

    return Row(
      children: [
        displayIcon,
        displayIcon,
      ],
    );
  }

  Widget btnBackwardArrows() {
    Icon displayIcon = Icon(
      Icons.arrow_back_ios_rounded,
      color: Colors.white,
    );

    return Row(
      children: [
        displayIcon,
        displayIcon,
      ],
    );
  }

  /*Widget btnArrows() {
    Icon displayIcon = Icon(
      !_dismissed
          ? Icons.arrow_forward_ios_rounded
          : Icons.arrow_back_ios_rounded,
      color: Colors.white,
    );

    return Row(
      children: [
        displayIcon,
        displayIcon,
      ],
    );
  }*/
}
