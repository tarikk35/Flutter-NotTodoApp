import 'package:flutter/material.dart';

class TransparentAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Positioned(
        top: 0,
        left: 0,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Not to do',
            style: TextStyle(fontSize: 44,fontFamily: 'Kingsman'),
          ),
        ),
      ),
    );
  }
}
