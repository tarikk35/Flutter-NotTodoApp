import 'package:flutter/material.dart';

class MyAnimatedIcon extends StatefulWidget {
  final double beginningSize;
  final double targetSize;
  final icon;
  final color1;
  final color2;
  final Function onPressed;
  final int index;
  final int currIndex;
  MyAnimatedIcon(
      {this.beginningSize,
      this.targetSize,
      this.icon,
      this.onPressed,
      this.color1,
      this.color2,
      this.index,
      this.currIndex});
  @override
  State<StatefulWidget> createState() {
    return _MyAnimatedIconState(
        beginningSize, targetSize, icon, color1, color2);
  }
}

class _MyAnimatedIconState extends State<MyAnimatedIcon>
    with TickerProviderStateMixin {
  final double beginningSize;
  final double targetSize;
  final color1;
  final color2;
  final icon;

  Animation<double> sizeAnimation;
  Animation<Color> colorAnimation;
  AnimationController sizeController;
  AnimationController colorController;

  _MyAnimatedIconState(
    this.beginningSize,
    this.targetSize,
    this.icon,
    this.color1,
    this.color2,
  );
  @override
  void initState() {
    super.initState();
    sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
        } else if (status == AnimationStatus.dismissed) {}
      });
    colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    sizeAnimation = Tween<double>(begin: beginningSize, end: targetSize)
        .animate(sizeController)
          ..addListener(() {
            setState(() {});
          });
    colorAnimation =
        ColorTween(begin: color1, end: color2).animate(colorController)
          ..addListener(() {
            setState(() {});
          });
    if (widget.currIndex == widget.index) _forward();
  }

  @override
  void didUpdateWidget(MyAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.currIndex == widget.index ? _forward() : _reverse();
  }

  void _forward() {
    colorController.forward();
    sizeController.forward();
  }

  void _reverse() {
    sizeController.reverse();
    colorController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: colorAnimation.value,
      iconSize: sizeAnimation.value,
      onPressed: () {
        widget.onPressed(widget.index);
        widget.index == widget.currIndex ? _forward() : _reverse();
      },
    );
  }

  @override
  void dispose() {
    sizeController.dispose();
    colorController.dispose();
    super.dispose();
  }
}
