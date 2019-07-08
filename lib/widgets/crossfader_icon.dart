import 'package:flutter/material.dart';

class CrossfaderIcon extends StatelessWidget {
  final currIndex, index, firstColor, icon, secondColor;
  CrossfaderIcon(
    this.index, {
    this.currIndex,
    this.firstColor,
    this.icon,
    this.secondColor,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 300),
      firstCurve: Curves.fastLinearToSlowEaseIn,
      firstChild: Icon(
        icon,
        color: firstColor,
        size: 30,
      ),
      secondChild: Icon(
        icon,
        color: secondColor,
        size: 64,
      ),
      crossFadeState:
          currIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
