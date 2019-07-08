import 'package:flutter/material.dart';

class FormTextbox extends StatefulWidget {
  final label, controller, icon;
  final String validationMsg,text;
  FormTextbox({this.label, this.controller, this.validationMsg,this.icon,this.text});
  @override
  State<StatefulWidget> createState() {
    return _FormTextboxState(controller);
  }
}

class _FormTextboxState extends State<FormTextbox> {
  final TextEditingController _controller;
  _FormTextboxState(this._controller);
  @override
  void initState() {
    if(widget.text!=null){
      _controller.text=widget.text;
    }
    super.initState();
  }
  @override
  void dispose() {
    _controller.text='';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            icon: widget.icon,
            labelText: widget.label,
            fillColor: Colors.white70),
        validator: (text) {
          if (text.isEmpty) {
            return widget.validationMsg;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
