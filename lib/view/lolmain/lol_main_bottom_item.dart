import 'package:flutter/material.dart';

class LoLMainBottomItem extends StatefulWidget {
  final int bottomIndex;
  final IconData iconData;
  final String iconText;
  final bool initialSelect;
  _LoLMainBottomItemState loLMainBottomItemState;

  LoLMainBottomItem({@required this.bottomIndex, this.iconData, this.iconText, this.initialSelect});

  @override
  _LoLMainBottomItemState createState() {
    loLMainBottomItemState = _LoLMainBottomItemState();
    return loLMainBottomItemState;
  }

  void setSelect(int index,bool select){
    if(loLMainBottomItemState != null){
      loLMainBottomItemState._setIconColor(index,select);
    }
  }

}

class _LoLMainBottomItemState extends State<LoLMainBottomItem> {
  Color _iconColor;
  Color _iconTextColor;

  @override
  void initState() {
    _setIconColor(widget.bottomIndex,widget.initialSelect);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        margin: EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Icon(widget.iconData,color: _iconColor),
          Text(widget.iconText,style: TextStyle(color: _iconTextColor))
        ]));
  }

  void _setIconColor(int index,bool select) {
    print("_setIconColor index $index select $select");
    setState(() {
      if (select) {
        _iconColor = Colors.orange;
        _iconTextColor = Colors.orange;
      }else {
        _iconColor = Colors.grey;
        _iconTextColor = Colors.grey;
      }
    });
  }
}
