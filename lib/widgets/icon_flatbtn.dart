import 'package:flutter/material.dart';

Widget iconFlatButton(func, color, icon) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal:25,vertical: 25),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: icon,
    ),
    onTap: () {
      func();
    },
  );
}
