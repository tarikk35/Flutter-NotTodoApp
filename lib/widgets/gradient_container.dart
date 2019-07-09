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
              Colors.white24,
              Colors.black12,
              Colors.black26
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            ),
      ),
      child: child!=null?child:null,
    );
  }
}
