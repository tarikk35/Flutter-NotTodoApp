import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final child;
  GradientContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.black26,
              Colors.black12,
              Colors.white24
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.2, 0.7]),
      ),
      child: child!=null?child:null,
    );
  }
}
