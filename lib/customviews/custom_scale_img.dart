import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/gesture/custom_gesture_detector.dart'
    as gd;

class CustomScaleImage extends StatefulWidget {
  final bool doubleTapStillScale;
  final String imgUrl;

  CustomScaleImage({Key key, this.doubleTapStillScale, this.imgUrl})
      : super(key: key);

  @override
  _CustomScaleImageState createState() => _CustomScaleImageState();
}

class _CustomScaleImageState extends State<CustomScaleImage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Offset _offset = Offset.zero;
  Offset _normalizedOffset;
  double _scale = 1.0;
  double _previousScale;
  double _kMinFlingVelocity = 600.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {
      setState(() {
        _offset = _animation.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return gd.GestureDetector(
        onTap: _handleOnTap,
        onDoubleTap: _handleOnDoubleTap,
        onScaleStart: _handleScaleOnStart,
        onScaleUpdate: _handleScaleOnUpdate,
        onScaleEnd: _handleScaleOnEnd,
        child: Container(
            constraints: BoxConstraints.expand(
                width: double.maxFinite, height: double.infinity),
            child: Transform(
              transform: Matrix4.identity()
                ..translate(_offset.dx, _offset.dy)
                ..scale(_scale, _scale, 1.0),
              child: Image.network(widget.imgUrl, fit: BoxFit.cover),
            )));
  }

  /**
   * _handle onTap
   * */
  void _handleOnTap() {
    Navigator.of(context).pop();
  }

  /**
   * _handle onDoubleTap
   * */
  void _handleOnDoubleTap(gd.DoubleDetails doubleDetails) {
    _normalizedOffset =
        (doubleDetails.pointerEvent.position - _offset) / _scale;
    if (!widget.doubleTapStillScale && _scale > 1.0) {
      setState(() {
        _scale = 1.0;
        _offset = Offset.zero;
      });
      return;
    }
    setState(() {
      if (widget.doubleTapStillScale) {
        _scale *= (1 + 0.3);
      } else {
        _scale *= 2;
      }
      _offset = _clampOffset(
          doubleDetails.pointerEvent.position - _normalizedOffset * _scale);
    });
  }

  /**
   * _handle scale OnStart
   * */
  void _handleScaleOnStart(gd.ScaleStartDetails scaleStartDetails) {
    setState(() {
      //设置当前scale为前一次scale
      _previousScale = _scale;
      //计算正常缩放的偏移量
      _normalizedOffset = (scaleStartDetails.focalPoint - _offset) / _scale;
      _animationController.stop();
    });
  }

  /**
   * _handle scale OnUpdate
   * */
  void _handleScaleOnUpdate(gd.ScaleUpdateDetails scaleUpdateDetails) {
    setState(() {
      //设置放大的倍数为1~3倍这个区间
      _scale = (_previousScale * scaleUpdateDetails.scale).clamp(1.0, 3.0);
      //计算缩放偏移量
      Offset _originOffset =
          (scaleUpdateDetails.focalPoint - _normalizedOffset * _scale);
      //更新最新位置
      _offset = _clampOffset(_originOffset);
    });
  }

  /**
   * _handle scale OnEnd
   * */
  void _handleScaleOnEnd(gd.ScaleEndDetails scaleEndDetails) {
    setState(() {
      //结束后速度量级
      final double magnitude =
          scaleEndDetails.velocity.pixelsPerSecond.distance;
      if (magnitude < _kMinFlingVelocity) return;
      //计算当前方向
      final Offset direction =
          scaleEndDetails.velocity.pixelsPerSecond / magnitude;
      //计算当前缩放速度
      final distance = (Offset.zero & context.size).shortestSide;
      //计算正常偏移量
      Offset _originOffset = _offset + direction * distance;
      _animation = _animationController.drive(
          Tween<Offset>(begin: _offset, end: _clampOffset(_originOffset)));
      _animationController
        ..value = 0.0
        ..fling(velocity: magnitude / 1000);
    });
  }

//设置缩放偏移量范围
  Offset _clampOffset(Offset originOffset) {
    //屏幕大小
    Size size = context.size;
    //设置最小偏移量
    final Offset _minOffset = Offset(size.width, size.height) * (1 - _scale);
    //返回最后的偏移量
    return Offset(originOffset.dx.clamp(_minOffset.dx, 0.0),
        originOffset.dy.clamp(_minOffset.dy, 0.0));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
