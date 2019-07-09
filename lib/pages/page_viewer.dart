import 'package:flutter/material.dart';
import 'package:ntd_app/models/scoped_ntd.dart';
import 'package:ntd_app/pages/form_page.dart';
import 'package:ntd_app/pages/main_page.dart';
import 'package:ntd_app/pages/temp_page.dart';
import 'package:ntd_app/widgets/my_animated_icon.dart';

class PageViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageViewerState();
  }
}

class _PageViewerState extends State<PageViewer> {
  PageController _controller;
  int currIndex = 1;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1)
      ..addListener(() {
        if (_controller.page > 1.8) {
          setState(() {
            currIndex = 2;
          });
        } else if (_controller.page < 0.2) {
          setState(() {
            currIndex = 0;
          });
        } else {
          setState(() {
            currIndex = 1;
          });
        }
      });
    AppModel.controller = _controller;
  }

  void _onPressedHandler(index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.clip,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyAnimatedIcon(
                    beginningSize: 28,
                    targetSize: 46,
                    color1: Colors.blue.shade200,
                    color2: Colors.blue.shade600,
                    icon: Icons.add,
                    onPressed: _onPressedHandler,
                    index: 0,
                    currIndex: currIndex,
                  ),
                  MyAnimatedIcon(
                    beginningSize: 46,
                    targetSize: 88,
                    color1: Colors.red.shade200,
                    color2: Colors.red.shade600,
                    icon: Icons.home,
                    onPressed: _onPressedHandler,
                    index: 1,
                    currIndex: currIndex,
                  ),
                  MyAnimatedIcon(
                    beginningSize: 28,
                    targetSize: 46,
                    color1: Colors.yellow.shade200,
                    color2: Colors.yellow.shade600,
                    icon: Icons.tag_faces,
                    onPressed: _onPressedHandler,
                    index: 2,
                    currIndex: currIndex,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                FormPage(),
                MainPage(),
                TempPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
