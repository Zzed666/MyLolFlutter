import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomProgressCircleWidget extends StatefulWidget {
  @override
  _CustomProgressCircleWidgetState createState() =>
      _CustomProgressCircleWidgetState();
}

class _CustomProgressCircleWidgetState extends State<CustomProgressCircleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _circleController;
  Animation<double> _circleAnimation;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    _circleController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    _curvedAnimation =
        CurvedAnimation(parent: _circleController, curve: Curves.linear);
    _circleAnimation = Tween(begin: 0.0, end: 360.0).animate(_circleController);
    _circleController.addListener(() {
      setState(() {});
    });
    _animationStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: CustomPaint(
            child: Center(
                child: Text("${(3.0 - (_circleAnimation.value * 3.0/ 360.0)).round()}s",style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none
                ))),
            painter: CustomCircleProgressPaint(_circleAnimation.value)));
  }

  void _animationStart() {
    _circleController.forward(from: 0.0);
  }

  @override
  void reassemble() {
    _animationStart();
    super.reassemble();
  }

  @override
  void dispose() {
    _circleController.dispose();
    super.dispose();
  }
}

class CustomCircleProgressPaint extends CustomPainter {
  var progress;
  Paint _circlePaint;
  Paint _arcPaint;

  CustomCircleProgressPaint(this.progress) {
    _circlePaint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.grey
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    _arcPaint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.white
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width/2, size.height/2),
        max(size.width/2, size.height/2), _circlePaint);
    Rect _arcRect = Rect.fromCircle(
        center: Offset(size.width/2, size.height/2),
        radius: max(size.width/2, size.height/2));
    canvas.drawArc(_arcRect, 0.0, 2 * pi * progress / 360, false, _arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}