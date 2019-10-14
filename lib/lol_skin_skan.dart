import 'package:flutter/material.dart';
import 'package:flutter_app/customviews/custom_scale_img.dart';

class LolSkinSkan extends StatefulWidget {
  final int skinIndex;
  final String skinUrl;
  const LolSkinSkan({Key key,this.skinIndex,this.skinUrl}) : super(key : key);
  @override
  _LolSkinSkanState createState() => _LolSkinSkanState();
}

class _LolSkinSkanState extends State<LolSkinSkan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.skinIndex,
        child: CustomScaleImage(doubleTapStillScale: false,imgUrl: widget.skinUrl)
      )
    );
  }
}
