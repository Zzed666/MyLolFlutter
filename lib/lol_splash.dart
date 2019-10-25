import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_progress_circle.dart';
import 'package:flutter_app/view/lolmain/lol_main.dart';

class LolSplash extends StatefulWidget {
  @override
  _LolSplashState createState() => _LolSplashState();
}

class _LolSplashState extends State<LolSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoLMain()),
            (route) => route == null);
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: <Widget>[
      ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: FadeTransition(
              opacity: _animation,
              child: Image.asset("images/img_lol_splash.jpg",
                  scale: 2.0, fit: BoxFit.cover))),
      Positioned(
          top: 30.0,
          right: 10.0,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoLMain()), (route) => route == null);
                _animationController.dispose();
              },
              child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CustomProgressCircleWidget())))
    ]));
  }
}
