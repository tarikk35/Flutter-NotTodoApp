import 'package:flutter/material.dart';
import 'package:ntd_app/pages/form_page.dart';
import 'package:ntd_app/pages/main_page.dart';
import 'package:ntd_app/pages/temp_page.dart';
import 'package:ntd_app/widgets/crossfader_icon.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ntd_app/models/scoped_ntd.dart';

class TabViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabViewerState();
  }
}

class _TabViewerState extends State<TabViewer>
    with SingleTickerProviderStateMixin {
  int currIndex = 1;
  TabController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TabController(length: 3, initialIndex: 1, vsync: this);
  //   AppModel.controller = _controller;
  //   _controller.addListener(() {
  //     setState(() {
  //       currIndex = _controller.index;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Colors.yellow.shade900,
                  Colors.yellow.shade800,
                  Colors.yellow.shade700,
                  Colors.yellow.shade600,
                ],
              ),
            ),
            child: TabBar(
              controller: _controller,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(vertical: 16),
              tabs: [
                CrossfaderIcon(
                  0,
                  currIndex: currIndex,
                  firstColor: Colors.white70,
                  secondColor: Colors.indigo,
                  icon: Icons.add_circle,
                ),
                CrossfaderIcon(
                  1,
                  currIndex: currIndex,
                  firstColor: Colors.white70,
                  secondColor: Colors.redAccent,
                  icon: Icons.whatshot,
                ),
                CrossfaderIcon(
                  2,
                  currIndex: currIndex,
                  firstColor: Colors.white70,
                  secondColor: Colors.yellow,
                  icon: Icons.star,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[FormPage(), MainPage(), TempPage()],
        ),
      ),
    );
  }
}
