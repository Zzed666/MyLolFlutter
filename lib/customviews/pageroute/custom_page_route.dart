import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget _widget;
  final int _routePageType;

  CustomPageRoute(this._routePageType, this._widget)
      : super(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return _widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget widget) {
              switch (_routePageType) {
                case PageRouteType.TYPE_PAGE_ROUTE_FADE:
                  //渐隐渐显
                  return FadeTransition(
                      child: widget,
                      opacity: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)));
                  break;
                case PageRouteType.TYPE_PAGE_ROUTE_SCALE:
                  //缩放
                  return ScaleTransition(
                      child: widget,
                      scale: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)));
                  break;
                case PageRouteType.TYPE_PAGE_ROUTE_ROTATE:
                  //旋转
                  return RotationTransition(
                      child: ScaleTransition(
                          child: widget,
                          scale: Tween(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastOutSlowIn))),
                      turns: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)));
                  break;
                case PageRouteType.TYPE_PAGE_ROUTE_SLDE:
                  //平移
                  return SlideTransition(
                      child: widget,
                      position: Tween<Offset>(
                              begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)));
                  break;
                default:
                  //平移
                  return SlideTransition(
                      child: widget,
                      position: Tween<Offset>(
                              begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)));
                  break;
              }
            });
}

class PageRouteType {
  static const int TYPE_PAGE_ROUTE_FADE = 1000;
  static const int TYPE_PAGE_ROUTE_SCALE = 1001;
  static const int TYPE_PAGE_ROUTE_ROTATE = 1002;
  static const int TYPE_PAGE_ROUTE_SLDE = 1003;
}
