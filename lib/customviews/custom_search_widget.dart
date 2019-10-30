import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchWidget extends StatefulWidget {
  //editText
  final String hintText;
  final Color hintTextColor;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;

  const CustomSearchWidget(
      {Key key,
      this.hintText: '请输入关键词',
      this.hintTextColor: Colors.grey,
      this.focusNode,
      this.textEditingController,
      this.prefixIcon: Icons.search,
      this.inputFormatters,
      this.onEditingComplete})
      : super(key: key);

  @override
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  bool _deleteVisiable;

  @override
  void initState() {
    _deleteVisiable = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0,10.0,10.0,10.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          shape: BoxShape.rectangle
        ),
        child: TextField(
          focusNode: widget.focusNode,
          keyboardType: TextInputType.text,
          maxLines: 1,
          inputFormatters: widget.inputFormatters,
          textInputAction: TextInputAction.done,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintMaxLines: 1,
            hintStyle: TextStyle(color: widget.hintTextColor, fontSize: 16.0),
            prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 20.0),
                child: Icon(widget.prefixIcon, color: Colors.black)),
            suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 2.0, end: _deleteVisiable ? 20.0 : 0.0),
                child: _deleteVisiable
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            WidgetsBinding.instance.addPostFrameCallback((_)=>widget.textEditingController.clear());
                            _deleteVisiable = false;
                          });
                        },
                        child:
                            Icon(Icons.clear, size: 16.0, color: Colors.black))
                    : Text("")),
            contentPadding: EdgeInsets.fromLTRB(0, 6.0, 0, 0),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          onChanged: (str) {
            print("onChanged string is empty is ${str.isEmpty}");
            setState(() {
              if (str.isEmpty) {
                _deleteVisiable = false;
              } else {
                _deleteVisiable = true;
              }
            });
          },
          onEditingComplete: widget.onEditingComplete,
        ));
  }
}
